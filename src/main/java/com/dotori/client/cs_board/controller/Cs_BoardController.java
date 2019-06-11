package com.dotori.client.cs_board.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dotori.client.cs_board.service.Cs_BoardService;
import com.dotori.client.cs_board.vo.Cs_BoardVO;
import com.dotori.client.cs_reply.service.Cs_ReplyService;
import com.dotori.common.vo.PageDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/cs_board/*")
@Log4j
@AllArgsConstructor
public class Cs_BoardController{
	/*어노테이션 @AllArgsConstructor = 모든 필드변수를 의존성 주입시켜준다. 아니면 Setter쓰시던가*/
	private Cs_BoardService cs_boardService;
	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------사진 URL복사-----------------------------------------------------------
	public void getClone (String cloneImg,String recDate) {
		String value = cloneImg;
		String fileName = "";
		ArrayList<String> array = new ArrayList<>();
		InputStream is = null;
		OutputStream os= null;
		while(value.indexOf("<img src=\"")!=-1) {
			value = value.substring(value.indexOf("<img src=\"")+10);
			fileName = value.substring(0, value.indexOf("\""));
			fileName = fileName.substring(fileName.lastIndexOf("/")+1);
			array.add(fileName);
		}
		
		String uploadStorage = "C:\\uploadStorage";
		String detailPath = "";
		if(recDate ==null || recDate.trim().equals("")) {
			detailPath = getFolder(uploadStorage+"\\cs_board");			
		} else {
			detailPath = recDate.replace("-", "\\\\");
		}
		
		try {
			for(int i = 0; i < array.size();i++) {					
				File file = new File(uploadStorage +"\\"+ array.get(i));
				Integer filesize = (int) file.length();
				is = new FileInputStream(uploadStorage.replace("\\", "/") +"/"+ array.get(i));
				os = new FileOutputStream(uploadStorage.replace("\\", "/") + "/cs_board/" + detailPath.replace("\\", "/") + "/" + array.get(i));
				int numRead;
				byte b[] = new byte[filesize];
				while ((numRead = is.read(b, 0, b.length)) != -1) {
					os.write(b, 0, numRead);
				}
				os.flush();
				os.close();							
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}
	private String getFolder(String folder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date).replaceAll("-", "\\\\");	
		File uploadPath = new File(folder,str);
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}
		return str;
	}
	
	//섬네일 이미지 
	private String getThumbnail(String getFile,String recDate) {
		String get = "C:\\uploadStorage\\cs_board\\"+ recDate.replaceAll("-", "\\\\") + "\\";
		File file = new File(get + getFile);
		log.info("file"+file);
		int index = getFile.lastIndexOf(".");
		String fileExt = getFile.substring(index + 1);
		try {			
			BufferedImage srcImg = ImageIO.read(file);
			//원본 이미지의 너비와 높이 입니다. 
			int dw = 100, dh = 	100; 
			
			// 원본 이미지의 너비와 높이 입니다. 
			int ow = srcImg.getWidth(); 
			int oh = srcImg.getHeight(); 
			
			// 원본 너비를 기준으로 하여 썸네일의 비율로 높이를 계산합니다. 
			int nw = ow; 
			int nh = (ow * dh) / dw; 
			
			// 계산된 높이가 원본보다 높다면 crop이 안되므로 // 원본 높이를 기준으로 썸네일의 비율로 너비를 계산합니다. 
			if(nh > oh) { 
				nw = (oh * dw) / dh; 
				nh = oh; 
			}

			BufferedImage cropImg = Scalr.crop(srcImg, (ow-nw)/2, (oh-nh)/2, nw, nh);
			
			BufferedImage destImg = Scalr.resize(cropImg, dw, dh);
			
			String thumbName = get + "THUMB_" + getFile; 
			File thumbFile = new File(thumbName); 
			ImageIO.write(destImg, fileExt.toUpperCase(), thumbFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return get;
	}
	//------------------------------------사진 URL복사-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------파일삭제---------------------------------------------------------------	
		public void getDelete (String html) {
			String htm = html;
			String htm1 = html;
			if(htm1.indexOf("<img src=\"")!=-1) {				
				htm1 = htm1.substring(htm1.indexOf("<img src=\"")+10);
				htm1 = htm1.substring(0, htm1.indexOf("\""));
				htm1 = htm1.substring(htm1.lastIndexOf("uploadStorage"));
				htm1 = "C:/"+htm1.replace(htm1.substring(htm1.lastIndexOf("/")),"/THUMB_" + htm1.substring(htm1.lastIndexOf("/")+1));
				File file1 = new File(htm1.replaceAll("/", "\\\\"));
				if(file1.exists()) {
					System.gc();
					file1.deleteOnExit();
					file1.delete();				
				}
			}
			while(htm.indexOf("<img src=") != -1) {
				htm = htm.substring(htm.indexOf("<img src=\"")+10);
				String str = htm;
				str = str.substring(0, str.indexOf("\""));
				str = str.substring(str.lastIndexOf("uploadStorage"));
				str = "C:\\" + str.replaceAll("/", "\\\\");
				File file = new File(str);
				
				if(file.exists()) {
					System.gc();
					file.deleteOnExit();
					file.delete();
				}
			}
		}
	//------------------------------------파일삭제---------------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	//--------------------------------------------------------------------------------------------------------
	//------------------------------------글쓰기 폼-----------------------------------------------------------
	@RequestMapping(value="/cs_writeForm")
	public String cs_writeForm(@ModelAttribute("data") Cs_BoardVO bvo,Model model) {
		
		return "cs_board/cs_writeForm";
	}
	
	//------------------------------------글쓰기 폼-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------관리자 게시글 등록-----------------------------------------------------------

	@RequestMapping(value="/master_cs_boardInsert", method=RequestMethod.POST)
	public String master_cs_boardInsert(@ModelAttribute Cs_BoardVO bvo, Model model) {
		getDelete(bvo.getEditor());
		bvo.setEditor(bvo.getEditor().replaceAll("uploadStorage/", "uploadStorage/cs_board/"+getFolder("C:\\uploadStorage\\cs_board").replace("\\", "/")+"/"));
		bvo.setEditor(bvo.getEditor().replaceAll("&nbsp;"," "));
		
		String thumb = bvo.getEditor();
		if(thumb.indexOf("<img src=\"")!=-1) {
			thumb = thumb.substring(thumb.indexOf("<img src=\"")+10);
			thumb = thumb.substring(0, thumb.indexOf("\""));
			thumb = thumb.substring(thumb.lastIndexOf("/")+1);
			getThumbnail(thumb,getFolder("C:\\uploadStorage\\cs_board").replace("\\", "-"));
		}
		
		int result = 0;
		String url ="";
		bvo.setT_editor(bvo.getEditor().replaceAll("[<][^>]*[>]", " ").trim());
		//임시 닉네임----------------------------------------
		bvo.setCs_name("testName");
		result = cs_boardService.master_cs_boardInsert(bvo);
		
		if(result == 1) {
			url ="/cs_board/cs_boardDetail_curr";
		}
		
		return "redirect:"+url;
	}
	//------------------------------------관리자 게시글 등록-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	//--------------------------------------------------------------------------------------------------------
	//------------------------------------게시글 등록-----------------------------------------------------------
	@RequestMapping(value="/cs_writeFormAction", method=RequestMethod.POST)
	public String cs_writeFormAction(@RequestParam("cs_html") String html) {
		getClone(html,null);
		getDelete(html);
		return "redirect:/cs_board/cs_writeForm";
	}

	@RequestMapping(value="/cs_boardInsert", method=RequestMethod.POST)
	public String cs_boardInsert(@ModelAttribute Cs_BoardVO bvo, Model model) {
		log.info("boardInsert 호출 성공");
		getDelete(bvo.getEditor());
		bvo.setEditor(bvo.getEditor().replaceAll("uploadStorage/", "uploadStorage/cs_board/"+getFolder("C:\\uploadStorage\\cs_board").replace("\\", "/")+"/"));
		bvo.setEditor(bvo.getEditor().replaceAll("&nbsp;"," "));
		
		String thumb = bvo.getEditor();
		if(thumb.indexOf("<img src=\"")!=-1) {
			thumb = thumb.substring(thumb.indexOf("<img src=\"")+10);
			thumb = thumb.substring(0, thumb.indexOf("\""));
			thumb = thumb.substring(thumb.lastIndexOf("/")+1);
			getThumbnail(thumb,getFolder("C:\\uploadStorage\\cs_board").replace("\\", "-"));
		}
		

		int result = 0;
		String url ="";
		bvo.setT_editor(bvo.getEditor().replaceAll("[<][^>]*[>]", " ").trim());
		//임시 닉네임----------------------------------------
		bvo.setCs_name("testName");
		result = cs_boardService.cs_boardInsert(bvo);
		
		if(result == 1) {
			url ="/cs_board/cs_boardDetail_curr";
		}
		
		//redirect: 를 쓰면 스프링 내부에서 자동적으로 response.sendRedirect(url)를 호출해준다.
		return "redirect:"+url;
	}
	//------------------------------------게시글 등록-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------글 상세정보-----------------------------------------------------------
	@RequestMapping(value="/cs_boardDetailHits", method=RequestMethod.GET)
	public String cs_boardDetailHits(@RequestParam("cs_num") int cs_num,@RequestParam("pageNum") int pageNum,@RequestParam("amount") int amount,@RequestParam(value = "path", required = false , defaultValue = "") String path,RedirectAttributes redirectAttributes) {
		String url = "";
		String t_Path="";
		int hits = cs_boardService.cs_hits(cs_num);
		Cs_BoardVO bvo = new Cs_BoardVO();
		hits++;
		bvo.setCs_hits(hits);
		bvo.setCs_num(cs_num);
		int result = cs_boardService.cs_hitsUpdate(bvo);
		if(result == 1) {
			url = "/cs_board/cs_boardDetail";
		}
		if(path!="") {
			t_Path = "&path="+path;
		}
		return "redirect:"+url+"?pageNum="+pageNum+"&amount=" +amount+"&cs_num="+cs_num + t_Path;
	}

	
	@RequestMapping(value="/cs_boardDetail", method=RequestMethod.GET)
	public String cs_boardDetail(@ModelAttribute("data") Cs_BoardVO bvo,Model model) {
		
		Cs_BoardVO cs_detail = cs_boardService.cs_boardDetail(bvo.getCs_num());
		model.addAttribute("cs_detail",cs_detail);
		
		
		return "cs_board/cs_boardDetail";
	}
	
	@RequestMapping(value="/cs_boardDetail_curr", method=RequestMethod.GET)
	public String cs_boardDetail_curr(RedirectAttributes redirectAttributes) {
		Cs_BoardVO cs_detail = cs_boardService.cs_boardDetail(cs_boardService.cs_boardDetail_currnum());
		redirectAttributes.addFlashAttribute("data",cs_detail);
		
		return "redirect:/cs_board/cs_boardDetail";
	}
	//------------------------------------글 상세정보-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	
	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------글 목록-----------------------------------------------------------
	@RequestMapping(value="/cs_boardList",method=RequestMethod.GET)
	public String boardList(@ModelAttribute("data") Cs_BoardVO bvo,Model model) {
		List<Cs_BoardVO> cs_boardList = cs_boardService.cs_boardList(bvo);
		for(int i = 0; i < cs_boardList.size();i++) {
			String str = cs_boardList.get(i).getEditor();
			if(str.indexOf("<img src=\"")!=-1) {
				String subStr = ""; 
				str = str.substring(str.indexOf("<img src=\""));
				str = str.substring(0, str.indexOf("\">")+2);
				subStr = str.substring(str.lastIndexOf("/")+1,str.indexOf("."));
				str = str.replaceAll(subStr, "THUMB_"+subStr);
				cs_boardList.get(i).setEditor(str);
			} else {
				cs_boardList.get(i).setEditor("");				
			}
		}
		List<Cs_BoardVO> master_cs_boardList = cs_boardService.master_cs_boardList(bvo);
		for(int i = 0; i < master_cs_boardList.size();i++) {
			String str = master_cs_boardList.get(i).getEditor();
			if(str.indexOf("<img src=\"")!=-1) {
				String subStr = ""; 
				str = str.substring(str.indexOf("<img src=\""));
				str = str.substring(0, str.indexOf("\">")+2);
				subStr = str.substring(str.lastIndexOf("/")+1,str.indexOf("."));
				str = str.replaceAll(subStr, "THUMB_"+subStr);
				master_cs_boardList.get(i).setEditor(str);
			} else {
				master_cs_boardList.get(i).setEditor("");				
			}
		}
		model.addAttribute("cs_boardList",cs_boardList);
		model.addAttribute("master_cs_boardList",master_cs_boardList);
		
		//전체 레코드 수 구현
		int total = cs_boardService.cs_boardListCnt(bvo);
		model.addAttribute("pageMaker",new PageDTO(bvo,total));
		
		return "cs_board/cs_boardList";
	}
	//------------------------------------글 목록-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	//--------------------------------------------------------------------------------------------------------
	//------------------------------------업데이트 뷰-----------------------------------------------------------
	@RequestMapping(value="/cs_updateForm")
	public String updateForm(@ModelAttribute("data") Cs_BoardVO bvo,@RequestParam("cs_num") int cs_num, Model model) {
		
		Cs_BoardVO cs_updateDate = cs_boardService.cs_updateForm(cs_num);
		model.addAttribute("cs_updateData", cs_updateDate);
		return "cs_board/cs_updateForm";
	}
	
	//------------------------------------업데이트 뷰-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	//--------------------------------------------------------------------------------------------------------
	//------------------------------------데이터 업데이트-----------------------------------------------------------

	@RequestMapping(value="/cs_updateFormAction", method=RequestMethod.POST)
	public String cs_updateFormAction(@RequestParam("cs_html") String html,@RequestParam("cs_num") int cs_num) {
		Cs_BoardVO bvo= cs_boardService.cs_boardDetail(cs_num);
		String outStr = bvo.getEditor();
		String getStr = html;
		while(outStr.indexOf("<img src=\"") != -1) {
			outStr = outStr.substring(outStr.indexOf("<img src=\""));
			String innerStr1 = outStr.substring(0, outStr.indexOf("\">")+2);
			outStr = outStr.substring(outStr.indexOf("\">")+2);
			getStr = getStr.replace(innerStr1, "");
		}
		if(getStr.contains("<img src=\"")) {
			getClone(getStr,bvo.getCs_regDate());			
		}
		return "redirect:/cs_board/cs_updateForm";
	}
	
	@RequestMapping(value="/cs_boardUpdate", method=RequestMethod.POST)
	public String updateForm(@ModelAttribute Cs_BoardVO bvo, RedirectAttributes ras) {
		log.info("boardUpdate 호출 성공");
		
		int result = 0;
		String url = "";
		Cs_BoardVO beforeBvo = cs_boardService.cs_boardDetail(bvo.getCs_num());
		
		bvo.setEditor(getUpdate(beforeBvo.getEditor(), bvo.getEditor(), beforeBvo.getCs_regDate()));
		
		bvo.setT_editor(bvo.getEditor().replaceAll("[<][^>]*[>]", " ").trim());
		
		result = cs_boardService.cs_boardUpdate(bvo);
		
		ras.addFlashAttribute("data",bvo);
		
		if(result==1) {
			url="/cs_board/cs_boardDetail";
		}
		return "redirect:"+url;
	}
	
	public String getUpdate(String before,String after,String recDate) {
		String result = after;
		String beforeStr = before;
		List<String> beforeList = new ArrayList<String>();
		while(beforeStr.indexOf("<img src=\"") != -1) {
			beforeStr = beforeStr.substring(beforeStr.indexOf("<img src=\""));
			String beforeStr1 = beforeStr.substring(0, beforeStr.indexOf("\">")+2);
			beforeStr = beforeStr.substring(beforeStr.indexOf("\">")+2);
			beforeList.add(beforeStr1);
		}
		if(after.indexOf("<img src=\"")!=-1) {
			String afterStr = after;
			List<String> afterList1 = new ArrayList<String>();
			List<String> afterList = new ArrayList<String>();
			while(afterStr.indexOf("<img src=\"") != -1) {
				afterStr = afterStr.substring(afterStr.indexOf("<img src=\""));
				String afterStr1 = afterStr.substring(0, afterStr.indexOf("\">")+2);
				afterStr = afterStr.substring(afterStr.indexOf("\">")+2);
				afterList1.add(afterStr1);
				if(!afterStr1.contains("cs_board/")) {
					getDelete(afterStr1);
					if(!recDate.trim().equals("")||recDate != null) {				
						afterStr1 = afterStr1.replaceAll("uploadStorage/", "uploadStorage/cs_board/"+recDate.replaceAll("-", "/")+"/");
					}
				}
				afterList.add(afterStr1);			
			}
			result = after;
			for(int i = 0; i < afterList.size();i++) {
				result = result.replace(afterList1.get(i), afterList.get(i));			
			}
			String befStr = beforeList.toString();
			for(int i = 0; i < afterList.size();i++) {
				befStr = befStr.replaceAll(afterList.get(i), "");
			}
			getDelete(befStr);
			String thumFileName = afterList.get(0);
			if(beforeList.size()!=0) {				
				if(!beforeList.get(0).equals(afterList.get(0))){
					getDelete(beforeList.get(0).replaceAll(beforeList.get(0).substring(beforeList.get(0).lastIndexOf("/")+1),"THUMB_"+beforeList.get(0).substring(beforeList.get(0).lastIndexOf("/")+1)));
					if(thumFileName.indexOf("<img src=\"")!=-1) {
						thumFileName = thumFileName.substring(thumFileName.indexOf("<img src=\"")+10);
						thumFileName = thumFileName.substring(0, thumFileName.indexOf("\""));
						thumFileName = thumFileName.substring(thumFileName.lastIndexOf("/")+1);
						getThumbnail(thumFileName,recDate);
					}
				} 
			} else {
				if(thumFileName.indexOf("<img src=\"")!=-1) {
					thumFileName = thumFileName.substring(thumFileName.indexOf("<img src=\"")+10);
					thumFileName = thumFileName.substring(0, thumFileName.indexOf("\""));
					thumFileName = thumFileName.substring(thumFileName.lastIndexOf("/")+1);
					getThumbnail(thumFileName,recDate);
				}				
			}
		} else {
			getDelete(before);
		}
		return result;
	}
	
	//------------------------------------데이터 업데이트-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	
	//------------------------------------데이터 삭제-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/cs_boardDelete")
	public String boardDelete(@ModelAttribute Cs_BoardVO bvo) {
		log.info("boardDelete 호출 성공");
		int result = 0;
		String url = "";
		Cs_BoardVO bvo1 = cs_boardService.cs_boardDetail(bvo.getCs_num());
		result = cs_boardService.cs_boardDelete(bvo.getCs_num());
		getDelete(bvo1.getEditor());
		if(result ==1) {
			url="/cs_board/cs_boardList";
		}
		return "redirect:"+url;
	}
	
	//------------------------------------데이터 삭제-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	
}
