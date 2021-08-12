use crate::Block;
use std::sync::{Arc, Mutex};
use tokio::sync::Notify;

pub struct Battery {
	state: Arc<Mutex<Option<State>>>,
}

struct State {
	charging: bool,
	level: u32,
}

const BATTERY_DISCHARGING: [char; 10] = [
	'\u{f579}', // 10
	'\u{f57a}', // 20
	'\u{f57b}', // 30
	'\u{f57c}', // 40
	'\u{f57d}', // 50
	'\u{f57e}', // 60
	'\u{f57f}', // 70
	'\u{f580}', // 80
	'\u{f581}', // 90
	'\u{f578}', // 100
];

const BATTERY_CHARGING: [char; 10] = [
	'\u{f585}', // 10
	'\u{f585}', // 20
	'\u{f586}', // 30
	'\u{f587}', // 40
	'\u{f588}', // 50
	'\u{f588}', // 60
	'\u{f589}', // 70
	'\u{f589}', // 80
	'\u{f58a}', // 90
	'\u{f584}', // 100
];

impl Battery {
	pub fn new() -> Battery {
		Battery {
			state: Arc::new(Mutex::new(None)),
		}
	}
}

impl Block for Battery {
	fn start(&mut self, _notify: Arc<Notify>) {}

	fn render(&mut self) -> Option<swaybar_types::Block> {
		let icon = BATTERY_DISCHARGING[0];
		let percent = 0.0;
		let text = format!(" {} {}% ", icon, percent);
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
