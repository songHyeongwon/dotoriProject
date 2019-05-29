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
	//���� ���ε� �� ���� ����
	public static void makeDir(String docRoot) {
		File fileDir = new File(docRoot);
		if(fileDir.exists()) {//��λ� ������ �ִ°� true, false��ȯ
			return;
		}
		//��λ� ������ �ִٸ� ������ �����.
		fileDir.mkdirs();
	}
	
	 /*
	 * ���Ͼ��ε� �޼���
	 * ���ϸ��� �ߺ��� �ذ���
	 * System.currentTimeMillis()�� ����ϰų� UUID�� 128qlxmdml tndlek.
	 * ǥ�����Ŀ��� UUID�� 32���� 16������ ǥ���Ǹ� �� 36�� ����(32�� ���ڿ� 4���� ������)��
	 * �� 8-4-4-4-12��� 5���� �׷��� ���������� �����Ѵ�. �̸��׸� ������ ����.
	 * �̶� UUID.randomUUID().toString()�� �̿��ؼ� ��´�.
	 * 5e15165e-bn1t-441d-a549-545465151161
	 */
	//���� ���ε� �޼���
	public static String fileUpload(MultipartFile file, String fileName) throws IOException{
		log.info("fileUpload ȣ�� ����");
		String real_name = null;//���� ������ �̸�
		String org_name = file.getOriginalFilename();//������ �����̸�
		log.info("org_name = "+org_name);
		
		//���ϸ� ����
		if(org_name != null && (!org_name.equals(""))) {
			//�����̸� ����, ���ϸ�_�ð�_���������̸� 
			real_name = fileName + "_"+System.currentTimeMillis()+"_"+org_name;
			String docRoot = "C://uploadStorage//"+fileName;
			makeDir(docRoot);//��λ� ���� ����
			
			File fileAdd = new File(docRoot+"/"+real_name);//���� ������
			log.info("���ε��� ����(fileAdd) : "+fileAdd);
			
			file.transferTo(fileAdd);
		}
		return real_name;
	}
	
	//���� ���� �޼���
	public static void fileDelete(String fileName) throws IOException{
		log.info("fileDelete ȣ�� ����");
		boolean result = false;
		String startDirName ="", docRoot="";
		String dirName = fileName.substring(0, fileName.indexOf("_"));
		//String docRoot = "C://uploadStorage//"+dirName;
		
		//������ϰ�� ���ϻ��� ��� ����
		if(dirName.equals("thumbnail")) {
			startDirName = fileName.substring(dirName.length()+1, fileName.indexOf("_",dirName.length()+1));
			docRoot = "C://uploadStorage//"+startDirName+"//"+dirName;
		}else {
			docRoot = "C://uploadStorage//"+dirName;
		}
		
		File fileDelete = new File(docRoot+"/"+fileName); // ���� ������
		log.info("������ ����(fileDelete) : "+fileDelete);
		if(fileDelete.exists() && fileDelete.isFile()) {
			result = fileDelete.delete();//���� ����
		}
		log.info("���� ���� ����(true, false) : "+result);
		
		
	}
	//���� Thumbnail ���� �޼���
	public static String makeThumbnail(String fileName) throws Exception{
		String dirName = fileName.substring(0, fileName.indexOf("_"));
		//�̹����� �����ϴ� ���� ����
		String imgPath = "C://uploadStorage//"+dirName;
		//����� ������ ���� ���(��������ġ : C:\...)
		File fileAdd = new File(imgPath,fileName);
		log.info("���� �̹�������(fileName) : "+fileName);
		
		BufferedImage sourceImg = ImageIO.read(fileAdd);
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT,200);
		
		String thumbnailName = "thumbnail_"+fileName;
		String docRoot = imgPath+"/thumbnail";
		makeDir(docRoot);
		
		File newFile = new File(docRoot,thumbnailName);
		log.info("���ε��� ����(newFile) : "+newFile);
		
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		log.info("Ȯ����(formatName) : "+formatName);
		
		ImageIO.write(destImg, formatName, newFile);
		System.out.println(thumbnailName);
		return thumbnailName;
	}
}
