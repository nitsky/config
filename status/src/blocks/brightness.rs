use crate::Block;
use std::sync::Arc;
use tokio::sync::Notify;

pub struct Brightness;

impl Block for Brightness {
	fn start(&mut self, _notify: Arc<Notify>) {}

	fn render(&mut self) -> Option<swaybar_types::Block> {
		let percent = 0.0;
		let text = format!(" \u{f5df} {}% ", percent);
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
