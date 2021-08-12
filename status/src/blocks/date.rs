use crate::Block;
use chrono::prelude::*;
use std::sync::Arc;
use tokio::sync::Notify;

pub struct Date;

impl Date {
	pub fn new() -> Date {
		Date
	}
}

impl Block for Date {
	fn start(&mut self, notify: Arc<Notify>) {
		let now = std::time::SystemTime::now();
		let epoch = std::time::UNIX_EPOCH;
		let nanos = now.duration_since(epoch).unwrap().subsec_nanos();
		let nanos = std::time::Duration::from_nanos(nanos as u64);
		let one_second = std::time::Duration::from_secs(1);
		let now = tokio::time::Instant::now();
		let next_second = now - nanos + one_second;
		let period = std::time::Duration::from_secs(1);
		let mut interval = tokio::time::interval_at(next_second, period);
		tokio::spawn(async move {
			loop {
				interval.tick().await;
				notify.notify_one();
			}
		});
	}

	fn render(&mut self) -> Option<swaybar_types::Block> {
		let date = Local::now().format("%a %h %d %H:%M:%S");
		let full_text = format!(" {} ", date);
		Some(swaybar_types::Block {
			full_text,
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
