/** INPLACE SCRIPT */
/**
 * this script script can be run in place at the directory where it is located 
 */

import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.awt.image.ColorModel;
import java.awt.image.WritableRaster;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

public class GenerateIcons {

	public static String[] names = {"bauxite-ore", "cobalt-ore", "gem-ore", "gold-ore",
		"lead-ore", "nickel-ore", "quartz", "rutile-ore", "silver-ore", "tin-ore",
		"tungsten-ore", "zinc-ore",
		"aluminium-plate", "lead-plate", "tin-plate", "silver-plate", "glass", "resin", "rubber", 
		"gold-plate", "cobalt-plate","tungsten-plate", "zinc-plate", "nickel-plate", "titanium-plate",
		"bronze-plate", "brass-plate", "electrum-plate", "invar-plate"};

	public static void main(String[] args) throws IOException {
		System.out.println("Creating -pack -unpack png images...");
		BufferedImage pack = ImageIO.read(new File("icons/pack.png"));
		BufferedImage unpack = ImageIO.read(new File("icons/unpack.png"));

		for (String item : names) {
			BufferedImage packIcon = ImageIO.read(new File("icons/" + item + "-box.png"));
			BufferedImage unpackIcon = copy(packIcon);
			Graphics g = packIcon.createGraphics();
			g.drawImage(pack, 0, 0, null);
			ImageIO.write(packIcon, "PNG", new File("icons/" + item + "-box-pack.png"));

			g = unpackIcon.createGraphics();
			g.drawImage(unpack, 0, 0, null);
			ImageIO.write(unpackIcon, "PNG", new File("icons/" + item + "-box-unpack.png"));
		}
		System.out.println("done.");
	}

	public static BufferedImage copy(BufferedImage img) {
		ColorModel cm = img.getColorModel();
		boolean isAlphaPremultiplied = cm.isAlphaPremultiplied();
		WritableRaster raster = img.copyData(null);
		return new BufferedImage(cm, raster, isAlphaPremultiplied, null);
	}
}