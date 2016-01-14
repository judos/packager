import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class GenerateNames {

	public static String[] names = {"bauxite-ore", "cobalt-ore", "gem-ore", "gold-ore",
		"lead-ore", "nickel-ore", "quartz", "rutile-ore", "silver-ore", "tin-ore",
		"tungsten-ore", "zinc-ore"};
	public static int boxSize = 10;

	public static void main(String[] args) throws IOException {
		System.out.println("Starting to generate labels...");
		File f = new File("generates-names.cfg");
		BufferedWriter wr = new BufferedWriter(new FileWriter(f));

		writeLine(wr, "[item-name]");
		for (String item : names) {
			String itemName = item.replaceAll("-", " ");
			writeLine(wr, item + "-box=" + itemName + " box");
		}
		wr.newLine();

		writeLine(wr, "[item-description]");
		for (String item : names) {
			String itemName = item.replaceAll("-", " ");
			writeLine(wr, item + "-box=A box filled with " + boxSize + " " + itemName);
		}
		wr.newLine();

		writeLine(wr, "[recipe-name]");
		for (String item : names) {
			String itemName = item.replaceAll("-", " ");
			writeLine(wr, item + "-box-pack=Pack " + boxSize + " " + itemName + " into a box");
			writeLine(wr, item + "-box-unpack=Take " + boxSize + " " + itemName
				+ " out of a box");
		}
		wr.newLine();

		wr.close();
		System.out.println("done.");
	}

	public static void writeLine(BufferedWriter w, String line) throws IOException {
		w.write(line);
		w.newLine();
	}

	public static String capitalize(String givenString) {
		String[] arr = givenString.split(" ");
		StringBuffer sb = new StringBuffer();

		for (int i = 0; i < arr.length; i++) {
			sb.append(Character.toUpperCase(arr[i].charAt(0))).append(arr[i].substring(1))
				.append(" ");
		}
		return sb.toString().trim();
	}
}