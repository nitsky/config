use std::sync::Arc;
use tokio::{io::AsyncWriteExt, sync::Notify};

trait Block {
	fn start(&mut self, notify: Arc<Notify>);
	fn render(&mut self) -> Option<swaybar_types::Block>;
}

mod blocks;

#[tokio::main(flavor = "current_thread")]
async fn main() {
	let mut stdout = tokio::io::stdout();
	let header = swaybar_types::Header {
		version: swaybar_types::Version::One,
		stop_signal: None,
		cont_signal: None,
		click_events: None,
	};
	let header = serde_json::to_vec(&header).unwrap();
	stdout.write_all(&header).await.unwrap();
	stdout.write_all("\n[".as_bytes()).await.unwrap();
	stdout.flush().await.unwrap();
	let notify = Arc::new(Notify::new());
	let mut blocks: Vec<Box<dyn Block>> = vec![
		Box::new(self::blocks::brightness::Brightness),
		Box::new(self::blocks::battery::Battery::new()),
		Box::new(self::blocks::network::Network),
		Box::new(self::blocks::audio::Audio::new()),
		Box::new(self::blocks::date::Date::new()),
	];
	for block in blocks.iter_mut() {
		block.start(notify.clone());
	}
	loop {
		let rendered_blocks: Vec<swaybar_types::Block> = blocks
			.iter_mut()
			.filter_map(|block| block.render())
			.collect();
		let rendered_blocks_json = serde_json::to_vec(&rendered_blocks).unwrap();
		stdout.write_all(&rendered_blocks_json).await.unwrap();
		stdout.write_all(",".as_bytes()).await.unwrap();
		stdout.flush().await.unwrap();
		notify.notified().await;
	}
}
