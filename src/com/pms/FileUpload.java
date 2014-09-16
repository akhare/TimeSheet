package com.pms;
import com.applix.tm1.TM1Bean;
import com.applix.tm1.TM1Cube;
import com.applix.tm1.TM1Dimension;
import com.applix.tm1.TM1Process;
import com.applix.tm1.TM1Server;
import com.applix.tm1.TM1Val;

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
import java.util.List;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.ImageOutputStream;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.applix.tm1.TM1Bean;
import com.applix.tm1.TM1Server;

public class FileUpload {

	private static String UPLOAD_DIRECTORY = "c:/pms/pmsupload";	
	private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3; // 3MB
	private static final int MAX_FILE_SIZE = 1024 * 1024 * 40; // 40MB
	private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB
	
	public static String projectCode;
	public static String billCategory;
	public static String expCategory;
	public static String expense;
	public static String remark;
	public static String receipt;
	public static String action;
	public static String eDate;
	public static String tm;
	public static String fullFilePath;
	
	

	public static void uploadFile(HttpServletRequest request, String employeeId)
			throws ServletException, IOException {	

		
		DiskFileItemFactory factory = new DiskFileItemFactory();		
		factory.setSizeThreshold(MEMORY_THRESHOLD);		
		factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

		ServletFileUpload upload = new ServletFileUpload(factory);		
		upload.setFileSizeMax(MAX_FILE_SIZE);		
		upload.setSizeMax(MAX_REQUEST_SIZE);
	
		
		
	
		

		try {
			
			@SuppressWarnings("unchecked")
			List<FileItem> formItems = upload.parseRequest(request);

			if (formItems != null && formItems.size() > 0) {
				for (FileItem item : formItems) {
					String name = item.getFieldName();
					String value = item.getString();
					if (name.equals("eDate")) {
						eDate = value;
					}
				}
			
				for (FileItem item : formItems) {					
					if (!item.isFormField()) {
						String originalfileName = new File(item.getName()).getName();
						String uploadPath = UPLOAD_DIRECTORY + generateFilePath(employeeId, eDate);
						File uploadDir = new File(uploadPath);
						if (!uploadDir.exists()) {
							boolean bool = uploadDir.mkdirs();
							System.out.print("Directory created? " + bool);
						}
						String fileName = generateFileName(originalfileName, eDate);
						System.out.println(fileName);
						String filePath = uploadPath + fileName;
						fullFilePath = filePath; 
						File storeFile = new File(filePath);					
					   // item.write(storeFile);
					    
					    String imageType = getExtension(filePath);
					    
					    if(imageType != null && imageType.equalsIgnoreCase(".jpg")){
					    /*	System.out.println(">>>> in codition True");
					    	System.out.println(">>>> in filePath "+ filePath);
					    	System.out.println();
					    	try{
					    	//CompressedImageFile.compressedImage(filePath, uploadPath, originalfileName, eDate, "jpg");
					    	}catch(Exception e){
					    		e.printStackTrace();
					    	}
					    }*/
					    InputStream is = null;
						OutputStream os = null;
						ImageOutputStream ios= null;
						ImageWriter writer= null ;
						try{						

						 //is = new FileInputStream(filePath);
							is=	item.getInputStream();
						 os = new FileOutputStream(filePath);
						
					    float quality = 0.2f;					  

						BufferedImage image = ImageIO.read(is);

						Iterator<ImageWriter> writers = ImageIO.getImageWritersByFormatName("jpg");// jpg

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
						}}
					    else{
					    	item.write(storeFile);
					    }
						
					} else{
						String name = item.getFieldName();
						String value = item.getString();
						if (name.equals("projectCode")) {
							projectCode = value;
						}
						if (name.equals("billCategory")) {
							billCategory = value;
						}
						if (name.equals("expCategory")) {
							expCategory = value;
						}
						if (name.equals("expense")) {
							expense = value;
						}
						if (name.equals("remark")) {
							remark = value;
						}
						if (name.equals("receipt")) {
							receipt = value;
						}
						if (name.equals("action")) {
							action = value;
						}
						if (name.equals("eDate")) {
							eDate = value;
						}
						if (name.equals("tm")) {
							tm = value;
						}
						if (name.equals("oldPath")) {
							File f = new File(value);
							if (f.exists()) {
								f.delete();
								System.out.println("Old file has been deleted.");
							}
						}
					}
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}

	}

	public static String generateFilePath(String employeeId,  String eDate) {
		String path = "";
		if (employeeId != null) {
			//Date now = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");	
			Date date = null;
			try {		 
				date = formatter.parse(eDate);
				System.out.println(date);
				System.out.println(formatter.format(date));
		 
			} catch (ParseException e) {
				e.printStackTrace();
			}
			path = "/" + employeeId + "/"
					+ new SimpleDateFormat("yyyy").format(date) + "/"
					+ new SimpleDateFormat("MM").format(date);

		}
		return path;
	}

	public static String generateFileName(String filePath, String eDate ) {
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
			
			path = "/" + new SimpleDateFormat("yyyyMMdd").format(date) + "_"	+ time + ext;
		
		}
				return path;
			
	}	
	
	public static String getExtension(String filePath){
		String ext = null;
		if (filePath != null) {
			int length = filePath.length();
			int i = filePath.lastIndexOf('.');
			ext = filePath.substring(i, length);
		}
		return ext;
	}
	
}
	
		
	
			
