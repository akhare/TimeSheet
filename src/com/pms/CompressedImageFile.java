package com.pms;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.ImageOutputStream;

public class CompressedImageFile {

	public static void compressedImage(String sourceFile, String uploadPath, String originalfileName, String eDate, String type)
			throws IOException {
		InputStream is = null;
		OutputStream os = null;
		ImageOutputStream ios= null;
		ImageWriter writer= null ;
try{
		File imageFile = new File(sourceFile);

		String fileName = generateFileName(originalfileName, eDate);
		System.out.println(fileName);
		String filePath = uploadPath + fileName;

		File compressedImageFile = new File(filePath);

		 is = new FileInputStream(imageFile);

		 os = new FileOutputStream(compressedImageFile);

		float quality = 0.2f;

		BufferedImage image = ImageIO.read(is);

		Iterator<ImageWriter> writers = ImageIO.getImageWritersByFormatName(type);// jpg

		if (!writers.hasNext())
			throw new IllegalStateException("No writers found");

		 writer = (ImageWriter) writers.next();

		 ios = ImageIO.createImageOutputStream(os);

		writer.setOutput(ios);

		ImageWriteParam param = writer.getDefaultWriteParam();

		param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
		param.setCompressionQuality(quality);

		writer.write(null, new IIOImage(image, null, null), param);
}catch(Exception e){
	e.printStackTrace();
}finally{
	if(is != null)
		is.close();
	if(os != null)
		os.close();
	if(ios != null)
		ios.close();
	if(writer != null)
		writer.dispose();
}

	}

	public static String generateFileName(String filePath, String eDate) {
		String path = "";
		String ext = null;
		if (filePath != null) {
			int length = filePath.length();
			int i = filePath.lastIndexOf('.');
			ext = filePath.substring(i, length);
			Date currentDate = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			Date date = null;
			try {
				date = formatter.parse(eDate);
				System.out.println(date);
				System.out.println(formatter.format(date));

			} catch (ParseException e) {
				e.printStackTrace();
			}
			String time = new SimpleDateFormat("HHmmss").format(currentDate);

			System.out.println(time);

			path = "/"+ new SimpleDateFormat("yyyyMMdd").format(date) + "_" + time + ext;

		}
		return path;

	}

}
