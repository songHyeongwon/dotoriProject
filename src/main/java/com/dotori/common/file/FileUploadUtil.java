package com.dotori.common.file;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Log4j
public class FileUploadUtil {
	//파일 업로드 할 폴더 생성
	public static void makeDir(String docRoot) {
		File fileDir = new File(docRoot);
		if(fileDir.exists()) {//경로상에 파일이 있는가 true, false반환
			return;
		}
		//경로상에 파일이 있다면 폴더를 만든다.
		fileDir.mkdirs();
	}
	
	 /*
	 * 파일업로드 메서드
	 * 파일명이 중복시 해결방법
	 * System.currentTimeMillis()를 사용하거나 UUID는 128qlxmdml tndlek.
	 * 표준형식에서 UUID는 32개의 16진수로 표현되며 총 36개 문자(32개 문자와 4개의 하이폰)로
	 * 된 8-4-4-4-12라는 5개의 그룹을 하이폰으로 구분한다. 이를테면 다음과 같다.
	 * 이때 UUID.randomUUID().toString()을 이용해서 얻는다.
	 * 5e15165e-bn1t-441d-a549-545465151161
	 */
	//파일 업로드 메서드
	public static String fileUpload(MultipartFile file, String fileName) throws IOException{
		log.info("fileUpload 호출 성공");
		String real_name = null;//실제 파일의 이름
		String org_name = file.getOriginalFilename();//파일의 원본이름
		log.info("org_name = "+org_name);
		
		//파일명 변경
		if(org_name != null && (!org_name.equals(""))) {
			//파일이름 변경, 파일명_시간_원본파일이름 
			real_name = fileName + "_"+System.currentTimeMillis()+"_"+org_name;
			String docRoot = "C://uploadStorage//"+fileName;
			makeDir(docRoot);//경로상에 폴더 생성
			
			File fileAdd = new File(docRoot+"/"+real_name);//파일 생성후
			log.info("업로드할 파일(fileAdd) : "+fileAdd);
			
			file.transferTo(fileAdd);
		}
		return real_name;
	}
	
	//파일 삭제 메서드
	public static void fileDelete(String fileName) throws IOException{
		log.info("fileDelete 호출 성공");
		boolean result = false;
		String startDirName ="", docRoot="";
		String dirName = fileName.substring(0, fileName.indexOf("_"));
		//String docRoot = "C://uploadStorage//"+dirName;
		
		//썸네일일경우 파일삭제 경로 수정
		if(dirName.equals("thumbnail")) {
			startDirName = fileName.substring(dirName.length()+1, fileName.indexOf("_",dirName.length()+1));
			docRoot = "C://uploadStorage//"+startDirName+"//"+dirName;
		}else {
			docRoot = "C://uploadStorage//"+dirName;
		}
		
		File fileDelete = new File(docRoot+"/"+fileName); // 파일 생성후
		log.info("삭제할 파일(fileDelete) : "+fileDelete);
		if(fileDelete.exists() && fileDelete.isFile()) {
			result = fileDelete.delete();//실제 삭제
		}
		log.info("파일 삭제 여부(true, false) : "+result);
		
		
	}
	//파일 Thumbnail 생성 메서드
	public static String makeThumbnail(String fileName) throws Exception{
		String dirName = fileName.substring(0, fileName.indexOf("_"));
		//이미지가 존재하는 폴더 추출
		String imgPath = "C://uploadStorage//"+dirName;
		//추출된 폴더의 실제 경로(물지적위치 : C:\...)
		File fileAdd = new File(imgPath,fileName);
		log.info("원폰 이미지파일(fileName) : "+fileName);
		
		BufferedImage sourceImg = ImageIO.read(fileAdd);
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT,200);
		
		String thumbnailName = "thumbnail_"+fileName;
		String docRoot = imgPath+"/thumbnail";
		makeDir(docRoot);
		
		File newFile = new File(docRoot,thumbnailName);
		log.info("업로드할 파일(newFile) : "+newFile);
		
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		log.info("확장자(formatName) : "+formatName);
		
		ImageIO.write(destImg, formatName, newFile);
		System.out.println(thumbnailName);
		return thumbnailName;
	}
}
