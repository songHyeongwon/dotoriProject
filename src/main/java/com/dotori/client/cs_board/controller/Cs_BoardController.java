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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dotori.client.cs_board.service.Cs_BoardService;
import com.dotori.client.cs_board.vo.Cs_BoardVO;
import com.dotori.client.member.service.MemberService;
import com.dotori.common.vo.PageDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/cs_board/*")
@Log4j
@AllArgsConstructor
public class Cs_BoardController{
	/*�뼱�끂�뀒�씠�뀡 @AllArgsConstructor = 紐⑤뱺 �븘�뱶蹂��닔瑜� �쓽議댁꽦 二쇱엯�떆耳쒖��떎. �븘�땲硫� Setter�벐�떆�뜕媛�*/
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
	
	//�꽟�꽕�씪 �씠誘몄� 
	private String getThumbnail(String getFile,String recDate) {
		String get = "C:\\uploadStorage\\cs_board\\"+ recDate.replaceAll("-", "\\\\") + "\\";
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
	@RequestMapping(value="/cs_writeForm")
	public String cs_writeForm(@ModelAttribute("data") Cs_BoardVO bvo,Model model) {
		
		return "cs_board/cs_writeForm";
	}
	
	//------------------------------------湲��벐湲� �뤌-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------愿�由ъ옄 寃뚯떆湲� �벑濡�-----------------------------------------------------------

	@RequestMapping(value="/master_cs_boardInsert", method=RequestMethod.POST)
	public String master_cs_boardInsert(@ModelAttribute Cs_BoardVO bvo,RedirectAttributes redirectAttributes, Model model) {
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
		//�엫�떆 �땳�꽕�엫----------------------------------------
		result = cs_boardService.master_cs_boardInsert(bvo);
		
		if(result == 1) {
			url ="/cs_board/cs_boardDetail_curr";
		}
		redirectAttributes.addFlashAttribute("write", "master_write");
		return "redirect:"+url;
	}
	//------------------------------------愿�由ъ옄 寃뚯떆湲� �벑濡�-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	//--------------------------------------------------------------------------------------------------------
	//------------------------------------寃뚯떆湲� �벑濡�-----------------------------------------------------------
	@RequestMapping(value="/cs_writeFormAction", method=RequestMethod.POST)
	public String cs_writeFormAction(@RequestParam("cs_html") String html) {
		getClone(html,null);
		getDelete(html);
		return "redirect:/cs_board/cs_writeForm";
	}

	@RequestMapping(value="/cs_boardInsert", method=RequestMethod.POST)
	public String cs_boardInsert(@ModelAttribute Cs_BoardVO bvo,RedirectAttributes redirectAttributes, Model model) {
		log.info("boardInsert �샇異� �꽦怨�");
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
		//�엫�떆 �땳�꽕�엫----------------------------------------
		result = cs_boardService.cs_boardInsert(bvo);
		
		if(result == 1) {
			url ="/cs_board/cs_boardDetail_curr";
		}
		
		//redirect: 瑜� �벐硫� �뒪�봽留� �궡遺��뿉�꽌 �옄�룞�쟻�쑝濡� response.sendRedirect(url)瑜� �샇異쒗빐以��떎.
		redirectAttributes.addFlashAttribute("write", "write");
		return "redirect:"+url;
	}
	//------------------------------------寃뚯떆湲� �벑濡�-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------湲� �긽�꽭�젙蹂�-----------------------------------------------------------
	
	//臾몄쓽 寃뚯떆湲� 議고쉶�닔
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
		if(path!="" || path != null) {
			t_Path = "&path="+path;
		}
		redirectAttributes.addFlashAttribute("cs_boardDetail", "cs_boardDetail");
		return "redirect:"+url+"?pageNum="+pageNum+"&amount=" +amount+"&cs_num="+cs_num + t_Path;
	}
	
	//愿�由ъ옄 怨듭� 寃뚯떆湲� 議고쉶�닔
	@RequestMapping(value="/master_cs_boardDetailHits", method=RequestMethod.GET)
	public String master_cs_boardDetailHits(@RequestParam("cs_num") int cs_num,@RequestParam("pageNum") int pageNum,@RequestParam("amount") int amount,@RequestParam(value = "path", required = false , defaultValue = "") String path,RedirectAttributes redirectAttributes) {
		String url = "";
		String t_Path="";
		int hits = cs_boardService.master_cs_hits(cs_num);
		Cs_BoardVO bvo = new Cs_BoardVO();
		hits++;
		bvo.setCs_hits(hits);
		bvo.setCs_num(cs_num);
		int result = cs_boardService.master_cs_hitsUpdate(bvo);
		if(result == 1) {
			url = "/cs_board/cs_boardDetail";
		}
		if(path.trim()!="" || path != null) {
			t_Path = "&path="+path;
		}
		redirectAttributes.addFlashAttribute("cs_boardDetail", "master_cs_boardDetail");
		return "redirect:"+url+"?pageNum="+pageNum+"&amount=" +amount+"&cs_num="+cs_num + t_Path;
	}

	
	@RequestMapping(value="/cs_boardDetail", method=RequestMethod.GET)
	public String cs_boardDetail(@ModelAttribute("boardData") Cs_BoardVO bvo,@ModelAttribute("cs_boardDetail") String request,Model model) {
		Cs_BoardVO cs_detail = null;
		String update = "";
		if(request.trim().equals("master_cs_boardDetail")) {
			cs_detail = cs_boardService.master_cs_boardDetail(bvo.getCs_num());
			update = "master_update";
		} else {
			cs_detail = cs_boardService.cs_boardDetail(bvo.getCs_num());
			update = "update";
		}
		model.addAttribute("cs_detail",cs_detail);
		model.addAttribute("update",update);
		
		return "cs_board/cs_boardDetail";
	}
	
	@RequestMapping(value="/cs_boardDetail_curr", method=RequestMethod.GET)
	public String cs_boardDetail_curr(RedirectAttributes redirectAttributes,@ModelAttribute("write") String write) {
		Cs_BoardVO cs_detail = null;
		String cs_boardDetail = "";
		if(write.trim().equals("master_write")) {
			cs_detail = cs_boardService.master_cs_boardDetail(cs_boardService.master_cs_boardDetail_currnum());	
			cs_boardDetail = "master_cs_boardDetail";
		} else {
			cs_detail = cs_boardService.cs_boardDetail(cs_boardService.cs_boardDetail_currnum());
			cs_boardDetail = "cs_boardDetail";
		}
		redirectAttributes.addFlashAttribute("cs_boardDetail",cs_boardDetail);
		redirectAttributes.addFlashAttribute("boardData",cs_detail);
		
		return "redirect:/cs_board/cs_boardDetail";
	}
	//------------------------------------湲� �긽�꽭�젙蹂�-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	
	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------湲� 紐⑸줉-----------------------------------------------------------
	@RequestMapping(value="/cs_boardList",method=RequestMethod.GET)
	public String boardList(@ModelAttribute Cs_BoardVO bvo,Model model) {
		List<Cs_BoardVO> cs_boardList = cs_boardService.cs_boardList(bvo);
		for(int i = 0; i < cs_boardList.size();i++) {
			String str = cs_boardList.get(i).getEditor();
			if(str.indexOf("<img src=\"")!=-1) {
				String subStr = ""; 
				str = str.substring(str.indexOf("<img src=\""));
				str = str.substring(0, str.indexOf("\">")+2);
				subStr = str.substring(str.lastIndexOf("/")+1);
				subStr = subStr.substring(0,subStr.indexOf("."));
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
				subStr = str.substring(str.lastIndexOf("/")+1);
				subStr = subStr.substring(0,subStr.indexOf("."));
				str = str.replaceAll(subStr, "THUMB_"+subStr);
				master_cs_boardList.get(i).setEditor(str);
			} else {
				master_cs_boardList.get(i).setEditor("");				
			}
		}
		model.addAttribute("cs_boardList",cs_boardList);
		model.addAttribute("master_cs_boardList",master_cs_boardList);
		
		//�쟾泥� �젅肄붾뱶 �닔 援ы쁽
		int total = cs_boardService.cs_boardListCnt(bvo);
		model.addAttribute("pageMaker",new PageDTO(bvo,total,10));
		
		return "cs_board/cs_boardList";
	}
	//愿�由ъ옄 怨듭� 寃뚯떆湲�
	@RequestMapping(value="/master_cs_boardAllList",method=RequestMethod.GET)
	public String master_boardList(@ModelAttribute("data") Cs_BoardVO bvo,Model model) {
		List<Cs_BoardVO> master_cs_boardList = cs_boardService.master_cs_boardAllList(bvo);
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
		model.addAttribute("master_cs_boardList",master_cs_boardList);
		
		//�쟾泥� �젅肄붾뱶 �닔 援ы쁽
		int total = cs_boardService.master_cs_boardListCnt(bvo);
		model.addAttribute("pageMaker",new PageDTO(bvo,total,10));
		
		return "cs_board/master_cs_boardAllList";
	}
	//------------------------------------湲� 紐⑸줉-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	//--------------------------------------------------------------------------------------------------------
	//------------------------------------�뾽�뜲�씠�듃 酉�-----------------------------------------------------------
	@RequestMapping(value="/cs_updateForm")
	public String updateForm(@ModelAttribute("data") Cs_BoardVO bvo,@ModelAttribute("update") String update,@RequestParam("cs_num") int cs_num, Model model) {
		Cs_BoardVO cs_updateDate = null;
		if(update.trim().equals("master_update")) {
			cs_updateDate = cs_boardService.master_cs_updateForm(cs_num);			
		} else {
			cs_updateDate = cs_boardService.cs_updateForm(cs_num);						
		}
		
		model.addAttribute("update", update);
		model.addAttribute("cs_updateData", cs_updateDate);
		return "cs_board/cs_updateForm";
	}
	
	//------------------------------------�뾽�뜲�씠�듃 酉�-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	//--------------------------------------------------------------------------------------------------------
	//------------------------------------�뜲�씠�꽣 �뾽�뜲�씠�듃-----------------------------------------------------------
	
	//臾몄쓽 寃뚯떆湲� �닔�젙 �쟾 �궗吏� 泥섎━
	@RequestMapping(value="/cs_updateFormAction", method=RequestMethod.POST)
	public String cs_updateFormAction(@RequestParam("cs_html") String html,@RequestParam("cs_num") int cs_num,@RequestParam("update") String update) {
		Cs_BoardVO bvo = null;
		if(update.trim().equals("master_update")) {
			bvo = cs_boardService.master_cs_boardDetail(cs_num);			
		} else {			
			bvo = cs_boardService.cs_boardDetail(cs_num);			
		}
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
	
	//臾몄쓽 寃뚯떆湲� �닔�젙
	@RequestMapping(value="/cs_boardUpdate", method=RequestMethod.POST)
	public String updateForm(@ModelAttribute Cs_BoardVO bvo,@ModelAttribute("update") String update, RedirectAttributes ras) {
		log.info("boardUpdate �샇異� �꽦怨�");
		
		int result = 0;
		String url = "";
		Cs_BoardVO beforeBvo =null;
		String cs_boardDetail = "";
		if(update.trim().equals("master_update")) {
			beforeBvo = cs_boardService.master_cs_boardDetail(bvo.getCs_num());
		}else {
			beforeBvo = cs_boardService.cs_boardDetail(bvo.getCs_num());
		}
		
		
		bvo.setEditor(getUpdate(beforeBvo.getEditor(), bvo.getEditor(), beforeBvo.getCs_regDate()));
		
		bvo.setT_editor(bvo.getEditor().replaceAll("[<][^>]*[>]", " ").trim());
		
		if(update.trim().equals("master_update")) {
			result = cs_boardService.master_cs_boardUpdate(bvo);
			cs_boardDetail = "master_cs_boardDetail";
		}else {
			result = cs_boardService.cs_boardUpdate(bvo);
			cs_boardDetail = "cs_boardDetail";
		}
		
		ras.addFlashAttribute("cs_boardDetail",cs_boardDetail);
		ras.addFlashAttribute("boardData",bvo);
		
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
	
	//------------------------------------�뜲�씠�꽣 �뾽�뜲�씠�듃-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	
	//------------------------------------�뜲�씠�꽣 �궘�젣-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	
	//臾몄쓽 寃뚯떆湲� �궘�젣
	@RequestMapping(value="/cs_boardDelete")
	public String boardDelete(@ModelAttribute Cs_BoardVO bvo,@ModelAttribute("update") String update) {
		log.info("boardDelete �샇異� �꽦怨�");
		int result = 0;
		String url = "";
		Cs_BoardVO bvo1 = null;
		if(update.trim().equals("master_update")) {
			bvo1 = cs_boardService.master_cs_boardDetail(bvo.getCs_num());
			result = cs_boardService.master_cs_boardDelete(bvo.getCs_num());						
		} else {
			bvo1 = cs_boardService.cs_boardDetail(bvo.getCs_num());
			result = cs_boardService.cs_boardDelete(bvo.getCs_num());			
		}
		getDelete(bvo1.getEditor());
		if(result ==1) {
			url="/cs_board/cs_boardList";
		}
		return "redirect:"+url;
	}
	
	//------------------------------------�뜲�씠�꽣 �궘�젣-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	
}
