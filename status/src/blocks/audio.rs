use crate::Block;
use libpulse_binding as pulseaudio;
use std::{cell::RefCell, rc::Rc, sync::mpsc::channel, sync::Arc, sync::Mutex};
use tokio::sync::Notify;

pub struct Audio {
	state: Arc<Mutex<Option<State>>>,
}

#[derive(Clone)]
struct State {
	muted: bool,
	volume: u32,
}

impl Audio {
	pub fn new() -> Audio {
		Audio {
			state: Arc::new(Mutex::new(None)),
		}
	}
}

impl Block for Audio {
	fn start(&mut self, notify: Arc<Notify>) {
		let (sender, receiver) = channel();
		sender.send(()).unwrap();
		let state = self.state.clone();
		std::thread::spawn(move || {
			let mut proplist = pulseaudio::proplist::Proplist::new().unwrap();
			proplist
				.set_str(pulseaudio::proplist::properties::APPLICATION_NAME, "status")
				.unwrap();
			let mut mainloop = pulseaudio::mainloop::standard::Mainloop::new().unwrap();
			let mut context =
				pulseaudio::context::Context::new_with_proplist(&mainloop, "status", &proplist)
					.unwrap();
			context
				.connect(None, pulseaudio::context::FlagSet::NOFLAGS, None)
				.unwrap();
			loop {
				match mainloop.iterate(false) {
					pulseaudio::mainloop::standard::IterateResult::Quit(_)
					| pulseaudio::mainloop::standard::IterateResult::Err(_) => panic!(),
					pulseaudio::mainloop::standard::IterateResult::Success(_) => {}
				}
				match context.get_state() {
					pulseaudio::context::State::Unconnected
					| pulseaudio::context::State::Connecting
					| pulseaudio::context::State::Authorizing
					| pulseaudio::context::State::SettingName => {}
					pulseaudio::context::State::Failed | pulseaudio::context::State::Terminated => {
						panic!()
					}
					pulseaudio::context::State::Ready => {
						break;
					}
				}
			}
			while receiver.recv().is_ok() {
				let default_sink_name = {
					let result = Rc::new(RefCell::new(None));
					let operation = {
						let result = result.clone();
						context.introspect().get_server_info(move |value| {
							let value = value.default_sink_name.as_ref().unwrap().to_owned();
							let value = value.to_string();
							*result.borrow_mut() = Some(value);
						})
					};
					loop {
						match mainloop.iterate(false) {
							pulseaudio::mainloop::standard::IterateResult::Quit(_)
							| pulseaudio::mainloop::standard::IterateResult::Err(_) => panic!(),
							pulseaudio::mainloop::standard::IterateResult::Success(_) => {}
						};
						match operation.get_state() {
							pulseaudio::operation::State::Running => {}
							pulseaudio::operation::State::Cancelled => {
								panic!()
							}
							pulseaudio::operation::State::Done => {
								break;
							}
						}
					}
					let result = result.borrow_mut().take().unwrap();
					result
				};
				*state.lock().unwrap() = Some({
					let result = Rc::new(RefCell::new(None));
					let operation = {
						let result = result.clone();
						context.introspect().get_sink_info_by_name(
							&default_sink_name,
							move |list| {
								let sink_info = match list {
									pulseaudio::callbacks::ListResult::Error => panic!(),
									pulseaudio::callbacks::ListResult::End => return,
									pulseaudio::callbacks::ListResult::Item(item) => item,
								};
								let muted = sink_info.mute;
								let volume = &sink_info.volume;
								let volume = (volume.avg().0 as f32
									/ pulseaudio::volume::Volume::NORMAL.0 as f32
									* 100.0)
									.round() as u32;
								*result.borrow_mut() = Some(State { muted, volume });
							},
						)
					};
					loop {
						match mainloop.iterate(false) {
							pulseaudio::mainloop::standard::IterateResult::Quit(_)
							| pulseaudio::mainloop::standard::IterateResult::Err(_) => panic!(),
							pulseaudio::mainloop::standard::IterateResult::Success(_) => {}
						};
						match operation.get_state() {
							pulseaudio::operation::State::Running => {}
							pulseaudio::operation::State::Cancelled => {
								panic!()
							}
							pulseaudio::operation::State::Done => {
								break;
							}
						};
					}
					let result = result.borrow_mut().take().unwrap();
					result
				});
				notify.notify_one();
			}
		});
		std::thread::spawn(move || {
			let mut proplist = pulseaudio::proplist::Proplist::new().unwrap();
			proplist
				.set_str(pulseaudio::proplist::properties::APPLICATION_NAME, "status")
				.unwrap();
			let mut mainloop = pulseaudio::mainloop::standard::Mainloop::new().unwrap();
			let mut context =
				pulseaudio::context::Context::new_with_proplist(&mainloop, "status", &proplist)
					.unwrap();
			context
				.connect(None, pulseaudio::context::FlagSet::NOFLAGS, None)
				.unwrap();
			loop {
				match mainloop.iterate(false) {
					pulseaudio::mainloop::standard::IterateResult::Quit(_)
					| pulseaudio::mainloop::standard::IterateResult::Err(_) => panic!(),
					pulseaudio::mainloop::standard::IterateResult::Success(_) => {}
				}
				match context.get_state() {
					pulseaudio::context::State::Unconnected
					| pulseaudio::context::State::Connecting
					| pulseaudio::context::State::Authorizing
					| pulseaudio::context::State::SettingName => {}
					pulseaudio::context::State::Failed | pulseaudio::context::State::Terminated => {
						panic!()
					}
					pulseaudio::context::State::Ready => {
						break;
					}
				}
			}
			context.set_subscribe_callback(Some(Box::new({
				move |facility, _operation, _index| {
					let facility = facility.unwrap();
					if facility == pulseaudio::context::subscribe::Facility::Sink {
						sender.send(()).unwrap();
					}
				}
			})));
			context.subscribe(
				pulseaudio::context::subscribe::InterestMaskSet::SINK,
				|_| {},
			);
			mainloop.run().unwrap();
		});
	}

	fn render(&mut self) -> Option<swaybar_types::Block> {
		const MUTED: char = '\u{fc5d}';
		const LOW: char = '\u{fa7e}';
		const MEDIUM: char = '\u{fa7f}';
		const HIGH: char = '\u{fa7d}';
		let State { muted, volume } = self.state.lock().unwrap().clone().unwrap_or(State {
			muted: true,
			volume: 0,
		});
		let icon = if muted {
			MUTED
		} else {
			match volume {
				0..=33 => LOW,
				34..=66 => MEDIUM,
				67..=100 => HIGH,
				_ => panic!(),
			}
		};
		let text = format!(" {} {}% ", icon, volume);
		Some(swaybar_types::Block {
			full_text: text,
			short_text: None,
			color: None,
			background: None,
			border: None,
			border_top: None,
			border_bottom: None,
			border_left: None,
			border_right: None,
			min_width: None,
			align: None,
			name: None,
			instance: None,
			urgent: None,
			separator: None,
			separator_block_width: None,
			markup: None,
		})
	}
}
