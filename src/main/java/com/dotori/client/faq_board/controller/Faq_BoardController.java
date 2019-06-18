package com.dotori.client.faq_board.controller;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dotori.client.cs_board.service.Cs_BoardService;
import com.dotori.client.cs_board.vo.Cs_BoardVO;
import com.dotori.client.faq_board.service.Faq_BoardService;
import com.dotori.client.faq_board.vo.Faq_BoardVO;
import com.dotori.common.vo.PageDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/faq_board/*")
@Log4j
@AllArgsConstructor
public class Faq_BoardController{
	/*�뼱�끂�뀒�씠�뀡 @AllArgsConstructor = 紐⑤뱺 �븘�뱶蹂��닔瑜� �쓽議댁꽦 二쇱엯�떆耳쒖��떎. �븘�땲硫� Setter�벐�떆�뜕媛�*/
	private Faq_BoardService faq_boardService;
	private Cs_BoardService cs_boardService;
	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------�궗吏� URL蹂듭궗-----------------------------------------------------------
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
			detailPath = getFolder(uploadStorage+"\\faq_board");			
		} else {
			detailPath = recDate.replace("-", "\\\\");
		}
		
		try {
			for(int i = 0; i < array.size();i++) {					
				File file = new File(uploadStorage +"\\"+ array.get(i));
				Integer filesize = (int) file.length();
				is = new FileInputStream(uploadStorage.replace("\\", "/") +"/"+ array.get(i));
				os = new FileOutputStream(uploadStorage.replace("\\", "/") + "/faq_board/" + detailPath.replace("\\", "/") + "/" + array.get(i));
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
	
	//�꽟�꽕�씪 �씠誘몄� 
	private String getThumbnail(String getFile,String recDate) {
		String get = "C:\\uploadStorage\\faq_board\\"+ recDate.replaceAll("-", "\\\\") + "\\";
		File file = new File(get + getFile);
		log.info("file"+file);
		int index = getFile.lastIndexOf(".");
		String fileExt = getFile.substring(index + 1);
		try {			
			BufferedImage srcImg = ImageIO.read(file);
			//�썝蹂� �씠誘몄��쓽 �꼫鍮꾩� �넂�씠 �엯�땲�떎. 
			int dw = 100, dh = 	100; 
			
			// �썝蹂� �씠誘몄��쓽 �꼫鍮꾩� �넂�씠 �엯�땲�떎. 
			int ow = srcImg.getWidth(); 
			int oh = srcImg.getHeight(); 
			
			// �썝蹂� �꼫鍮꾨�� 湲곗��쑝濡� �븯�뿬 �뜽�꽕�씪�쓽 鍮꾩쑉濡� �넂�씠瑜� 怨꾩궛�빀�땲�떎. 
			int nw = ow; 
			int nh = (ow * dh) / dw; 
			
			// 怨꾩궛�맂 �넂�씠媛� �썝蹂몃낫�떎 �넂�떎硫� crop�씠 �븞�릺誘�濡� // �썝蹂� �넂�씠瑜� 湲곗��쑝濡� �뜽�꽕�씪�쓽 鍮꾩쑉濡� �꼫鍮꾨�� 怨꾩궛�빀�땲�떎. 
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
	//------------------------------------�궗吏� URL蹂듭궗-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------�뙆�씪�궘�젣---------------------------------------------------------------
	
	
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
	//------------------------------------�뙆�씪�궘�젣---------------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	//--------------------------------------------------------------------------------------------------------
	//------------------------------------湲��벐湲� �뤌-----------------------------------------------------------
	@RequestMapping(value="/faq_writeForm")
	public String faq_writeForm(@ModelAttribute("data") Faq_BoardVO bvo,Model model) {
		
		return "faq_board/faq_writeForm";
	}
	
	//------------------------------------湲��벐湲� �뤌-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	
	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------寃뚯떆湲� �벑濡�-----------------------------------------------------------

	@RequestMapping(value="/faq_boardInsert", method=RequestMethod.POST)
	public String boardInsert(@ModelAttribute Faq_BoardVO bvo, Model model) {
		log.info("boardInsert �샇異� �꽦怨�");
		getClone(bvo.getEditor(),null);
		getDelete(bvo.getEditor());
		bvo.setEditor(bvo.getEditor().replaceAll("uploadStorage/", "uploadStorage/faq_board/"+getFolder("C:\\uploadStorage\\faq_board").replace("\\", "/")+"/"));
		bvo.setEditor(bvo.getEditor().replaceAll("&nbsp;"," "));
		
		String thumb = bvo.getEditor();
		if(thumb.indexOf("<img src=\"")!=-1) {
			thumb = thumb.substring(thumb.indexOf("<img src=\"")+10);
			thumb = thumb.substring(0, thumb.indexOf("\""));
			thumb = thumb.substring(thumb.lastIndexOf("/")+1);
			getThumbnail(thumb,getFolder("C:\\uploadStorage\\faq_board").replace("\\", "-"));
		}
		

		int result = 0;
		String url ="";
		bvo.setT_editor(bvo.getEditor().replaceAll("[<][^>]*[>]", " ").trim());
		result = faq_boardService.faq_boardInsert(bvo);
		
		if(result == 1) {
			url ="/faq_board/faq_boardDetail_curr";
		}
		
		//redirect: 瑜� �벐硫� �뒪�봽留� �궡遺��뿉�꽌 �옄�룞�쟻�쑝濡� response.sendRedirect(url)瑜� �샇異쒗빐以��떎.
		return "redirect:"+url;
	}
	//------------------------------------寃뚯떆湲� �벑濡�-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------湲� �긽�꽭�젙蹂�-----------------------------------------------------------

	@RequestMapping(value="/faq_boardDetail", method=RequestMethod.GET)
	public String faq_boardDetail(@ModelAttribute("boardData") Faq_BoardVO bvo,Model model) {
		
		Faq_BoardVO faq_detail = faq_boardService.faq_boardDetail(bvo.getFaq_num());
		System.out.println(faq_detail.getMember_id());
		model.addAttribute("faq_detail",faq_detail);
		
		
		return "faq_board/faq_boardDetail";
	}
	
	@RequestMapping(value="/faq_boardDetail_curr", method=RequestMethod.GET)
	public String faq_boardDetail_curr(RedirectAttributes redirectAttributes) {
		Faq_BoardVO faq_detail = faq_boardService.faq_boardDetail(faq_boardService.faq_boardDetail_currnum());
		redirectAttributes.addFlashAttribute("boardData",faq_detail);
		
		return "redirect:/faq_board/faq_boardDetail";
	}
	//------------------------------------湲� �긽�꽭�젙蹂�-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	
	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------湲� 紐⑸줉-----------------------------------------------------------
	@RequestMapping(value="/faq_boardList",method=RequestMethod.GET)
	public String boardList(@ModelAttribute Faq_BoardVO bvo,Model model) {
		List<Faq_BoardVO> faq_boardList = faq_boardService.faq_boardList(bvo);
		for(int i = 0; i < faq_boardList.size();i++) {
			String str = faq_boardList.get(i).getEditor();
			if(str.indexOf("<img src=\"")!=-1) {
				String subStr = ""; 
				str = str.substring(str.indexOf("<img src=\""));
				str = str.substring(0, str.indexOf("\">")+2);
				//subStr = str.substring(str.lastIndexOf("/")+1,str.indexOf("."));
				subStr = str.substring(str.lastIndexOf("/")+1);
				subStr = subStr.substring(0,subStr.indexOf("."));
				str = str.replaceAll(subStr, "THUMB_"+subStr);
				faq_boardList.get(i).setEditor(str);
			} else {
				faq_boardList.get(i).setEditor("");				
			}
		}
		model.addAttribute("faq_boardList",faq_boardList);
		
		//�쟾泥� �젅肄붾뱶 �닔 援ы쁽
		int total = faq_boardService.faq_boardListCnt(bvo);
		model.addAttribute("pageMaker",new PageDTO(bvo,total,10));
		
		return "faq_board/faq_boardList";
	}
	//------------------------------------湲� 紐⑸줉-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	//--------------------------------------------------------------------------------------------------------
	//------------------------------------�뾽�뜲�씠�듃 酉�-----------------------------------------------------------
	@RequestMapping(value="/faq_updateForm")
	public String updateForm(@ModelAttribute("data") Faq_BoardVO bvo,@RequestParam("faq_num") int faq_num, Model model) {
		
		Faq_BoardVO faq_updateDate = faq_boardService.faq_updateForm(faq_num);
		model.addAttribute("faq_updateData", faq_updateDate);
		return "faq_board/faq_updateForm";
	}
	
	//------------------------------------�뾽�뜲�씠�듃 酉�-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	//--------------------------------------------------------------------------------------------------------
	//------------------------------------�뜲�씠�꽣 �뾽�뜲�씠�듃-----------------------------------------------------------

	@RequestMapping(value="/faq_updateFormAction", method=RequestMethod.POST)
	public String faq_updateFormAction(@RequestParam("faq_html") String html,@RequestParam("faq_num") int faq_num) {
		Faq_BoardVO bvo= faq_boardService.faq_boardDetail(faq_num);
		String outStr = bvo.getEditor();
		String getStr = html;
		while(outStr.indexOf("<img src=\"") != -1) {
			outStr = outStr.substring(outStr.indexOf("<img src=\""));
			String innerStr1 = outStr.substring(0, outStr.indexOf("\">")+2);
			outStr = outStr.substring(outStr.indexOf("\">")+2);
			getStr = getStr.replace(innerStr1, "");
		}
		if(getStr.contains("<img src=\"")) {
			getClone(getStr,bvo.getFaq_regDate());			
		}
		return "redirect:/faq_board/faq_updateForm";
	}
	
	@RequestMapping(value="/faq_boardUpdate", method=RequestMethod.POST)
	public String updateForm(@ModelAttribute Faq_BoardVO bvo, RedirectAttributes ras) {
		log.info("boardUpdate �샇異� �꽦怨�");
		
		int result = 0;
		String url = "";
		Faq_BoardVO beforeBvo = faq_boardService.faq_boardDetail(bvo.getFaq_num());
		
		bvo.setEditor(getUpdate(beforeBvo.getEditor(), bvo.getEditor(), beforeBvo.getFaq_regDate()));
		
		bvo.setT_editor(bvo.getEditor().replaceAll("[<][^>]*[>]", " ").trim());
		
		result = faq_boardService.faq_boardUpdate(bvo);
		
		ras.addFlashAttribute("boardData",bvo);
		
		if(result==1) {
			url="/faq_board/faq_boardDetail";
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
				if(!afterStr1.contains("faq_board/")) {
					getDelete(afterStr1);
					if(!recDate.trim().equals("")||recDate != null) {				
						afterStr1 = afterStr1.replaceAll("uploadStorage/", "uploadStorage/faq_board/"+recDate.replaceAll("-", "/")+"/");
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
	
	//------------------------------------�뜲�씠�꽣 �뾽�뜲�씠�듃-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	
	//------------------------------------�뜲�씠�꽣 �궘�젣-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/faq_boardDelete")
	public String boardDelete(@ModelAttribute Faq_BoardVO bvo) {
		log.info("boardDelete �샇異� �꽦怨�");
		int result = 0;
		String url = "";
		Faq_BoardVO bvo1 = faq_boardService.faq_boardDetail(bvo.getFaq_num());
		result = faq_boardService.faq_boardDelete(bvo.getFaq_num());
		getDelete(bvo1.getEditor());
		if(result ==1) {
			url="/faq_board/faq_boardList";
		}
		return "redirect:"+url;
	}
	
	//------------------------------------�뜲�씠�꽣 �궘�젣-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------愿�由ъ옄 酉�--------------------------------------------------------------
	@RequestMapping(value="/faq_masterBoardList",method=RequestMethod.GET)
	public String boardList(@ModelAttribute("data") Cs_BoardVO bvo,Model model) {
		List<Cs_BoardVO> cs_boardList = cs_boardService.cs_boardList(bvo);
		for(int i = 0; i < cs_boardList.size();i++) {
			String str = cs_boardList.get(i).getEditor();
			if(str.indexOf("<img src=\"")!=-1) {
				String subStr = ""; 
				str = str.substring(str.indexOf("<img src=\""));
				str = str.substring(0, str.indexOf("\">")+2);
				//subStr = str.substring(str.lastIndexOf("/")+1,str.indexOf("."));
				subStr = str.substring(str.lastIndexOf("/")+1);
				subStr = subStr.substring(0,subStr.indexOf("."));
				str = str.replaceAll(subStr, "THUMB_"+subStr);
				cs_boardList.get(i).setEditor(str);
			} else {
				cs_boardList.get(i).setEditor("");				
			}
		}
		model.addAttribute("cs_boardList",cs_boardList);
		
		//�쟾泥� �젅肄붾뱶 �닔 援ы쁽
		int total = cs_boardService.cs_boardListCnt(bvo);
		model.addAttribute("pageMaker",new PageDTO(bvo,total,10));
		
		return "faq_board/faq_masterBoardList";
	}
	//------------------------------------愿�由ъ옄 酉�--------------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	
}
