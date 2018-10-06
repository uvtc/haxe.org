import sys.FileSystem;

class Main {

	public static function main () {
		Sys.println("== haxe.org generation ==");
		Sys.println('Output folder: "${Config.outputFolder}"');
		var start = Date.now().getTime();

		// Make sure the output folder exists
		if (!FileSystem.exists(Config.outputFolder)) {
			FileSystem.createDirectory(Config.outputFolder);
		}

		// Generating the content
		SiteMap.init();
		generators.Assets.generate();
		generators.Blog.generate();
		generators.Videos.generate();
		generators.Downloads.generate();
		generators.Javascript.generate();
		generators.Manual.generate(HxcppDoc.patchSections()); // Patch the manual content with the doc from hxcpp
		generators.Pages.generate();
		generators.Redirections.generate();
		generators.RobotsTxt.generate();

		// Patch as post process the html file with syntax highlighting
		SyntaxHighlighter.patch();

		var end = Date.now().getTime();
		Sys.println('Generation complete, time ${(end - start)/1000}s');
	}

}
