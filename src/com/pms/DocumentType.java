package com.pms;

import java.util.ArrayList;
import java.util.List;

public class DocumentType {

	public String extension;
	public String contentType;
	public String description;

	public DocumentType(String extension, String contentType, String description) {
		this.extension = extension;
		this.contentType = contentType;
		this.description = description;
	}

	public static DocumentType PDF = new DocumentType(".pdf", "application/pdf", "PDF file");
	public static DocumentType DOCUMENT = new DocumentType(".doc", "application/doc", "Word document");
	public static DocumentType WORD_DOCUMENT = new DocumentType(".docx", "application/word", "Word document");
	public static DocumentType EXCEL = new DocumentType(".xls", "application/vnd.ms-excel", "Excel document");
	public static DocumentType TEXT = new DocumentType(".txt", "text/plain", "Text file");
	public static DocumentType PNG = new DocumentType(".png", "application/png", "PNG file");
	public static DocumentType JPG = new DocumentType(".jpg", "application/jpg", "JPG file");
	public static DocumentType JPEG = new DocumentType(".jpeg", "application/jpg", "JPEG file");	

	public String getExtension() {
		return extension;
	}

	public String getContentType() {
		return contentType;
	}

	public String getDescription() {
		return description;
	}

	public static List<DocumentType> getList() {

		List<DocumentType> list = new ArrayList<DocumentType>();

		list.add(PDF);
		list.add(DOCUMENT);
		list.add(WORD_DOCUMENT);
		list.add(EXCEL);
		list.add(TEXT);
		list.add(PNG);
		list.add(JPG);
		list.add(JPEG);

		return list;
	}
	
	public static DocumentType getDocumentType(String extension) {
		DocumentType documentType = null;
		for (DocumentType type : getList()) {
			if (type.getExtension().equalsIgnoreCase(extension)) {
				documentType = type;
			}
		}
		return documentType;
	}

}
