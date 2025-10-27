package org.big.controller;

import java.io.File;
import java.io.IOException;

import org.big.dao.BookDao;
import org.big.dto.Book;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class BookMarketController {
	
	@Autowired
    private BookDao bookDao;

	@RequestMapping("/bookmarket/welcome.do")
	public String welcome() {
		return "/welcome";
	}
	
	@RequestMapping("/bookmarket/member/loginMember.do")
	public String login() {
		return "/member/loginMember";
	}
	
	@RequestMapping("/bookmarket/member/logoutMember.do")
	public String logoutMember() {
		return "/member/logoutMember";
	}
	
	@RequestMapping("/bookmarket/logout.do")
	public String logout() {
		return "/logout";
	}
	
	@RequestMapping("/bookmarket/member/resultMember.do")
	public String resultMember() {
		return "/member/resultMember";
	}
	
	@RequestMapping("/bookmarket/member/processAddMember.do")
	public String processAddMember() {
		return "/member/processAddMember";
	}
	
	@RequestMapping("/bookmarket/member/updateMember.do")
	public String updateMember() {
		return "/member/updateMember";
	}
	
	@RequestMapping("/bookmarket/member/processUpdateMember.do")
	public String processUpdateMember() {
		return "/member/processUpdateMember";
	}
	
	@RequestMapping("/bookmarket/member/deleteMember.do")
	public String deleteMember() {
		return "/member/deleteMember";
	}
	
	@RequestMapping("/bookmarket/menu.do")
	public String menu() {
		return "/menu";
	}
	
	@RequestMapping("/bookmarket/footer.do")
	public String footer() {
		return "/footer";
	}
	
	@RequestMapping("/bookmarket/member/processLoginMember.do")
	public String processLoginMember() {
		return "/member/processLoginMember";
	}
	
	@RequestMapping("/bookmarket/member/addMember.do")
	public String addMember() {
		return "/member/addMember";
	}
	
	@RequestMapping("/bookmarket/books.do")
	public String books() {
		return "/books";
	}
	
	@RequestMapping("/bookmarket/dbconn.do")
	public String dbconn() {
		return "/dbconn";
	}
	
	@RequestMapping("/bookmarket/addBook.do")
	public String addBook() {
		return "/addBook";
	}
	
	@RequestMapping("/bookmarket/processAddBook.do")
	public String processAddBook(@RequestParam("bookId") String bookId, 
	                             @RequestParam("name") String name,
	                             @RequestParam("unitPrice") String unitPrice, 
	                             @RequestParam("author") String author,
	                             @RequestParam("publisher") String publisher, 
	                             @RequestParam("releaseDate") String releaseDate,
	                             @RequestParam("description") String description, 
	                             @RequestParam("category") String category,
	                             @RequestParam("unitsInStock") String unitsInStock, 
	                             @RequestParam("condition") String condition,
	                             @RequestParam("bookImage") MultipartFile file, // MultipartFile로 파일 처리
	                             HttpServletRequest request) throws IOException {

	      // 가격과 재고 값 처리
	       int price = unitPrice.isEmpty() ? 0 : Integer.valueOf(unitPrice);
	       long stock = unitsInStock.isEmpty() ? 0 : Long.valueOf(unitsInStock);

	       // 파일 저장 경로
	       String uploadDir = request.getServletContext().getRealPath("/images");
	       File dir = new File(uploadDir);
	       if (!dir.exists()) {
	           dir.mkdirs(); // 디렉토리가 없다면 생성
	       }

	       String filename = file.getOriginalFilename();
	       if (!filename.isEmpty()) {
	           try {
	               file.transferTo(new File(uploadDir, filename)); // 파일 저장
	           } catch (IOException e) {
	               e.printStackTrace(); // 예외 처리
	               throw new IOException("파일 저장 중 오류 발생", e);
	           }
	       }

	       // Book DTO 객체 생성
	       Book book = new Book();
	       book.setBookId(bookId);
	       book.setName(name);
	       book.setUnitPrice(price); // unitPrice를 설정
	       book.setAuthor(author);
	       book.setPublisher(publisher);
	       book.setReleaseDate(releaseDate);
	       book.setDescription(description);
	       book.setCategory(category);
	       book.setUnitsInStock(stock); // unitsInStock을 설정
	       book.setCondition(condition);
	       book.setFilename(filename); // 파일명 저장

	       // DB에 저장
	       bookDao.insertBook(book);

	       return "redirect:/bookmarket/books.do";
	   }

	
	@RequestMapping("/bookmarket/editBook.do")
	public String editBook() {
		return "/editBook";
	}
	
	@RequestMapping("/bookmarket/updateBook.do")
	public String updateBook() {
		return "/updateBook";
	}
	
	@PostMapping("/bookmarket/processUpdateBook.do")
    public String processUpdateBook(@RequestParam("bookId") String bookId, 
                                    @RequestParam("name") String name,
                                    @RequestParam("unitPrice") String unitPrice, 
                                    @RequestParam("author") String author,
                                    @RequestParam("publisher") String publisher, 
                                    @RequestParam("releaseDate") String releaseDate,
                                    @RequestParam("description") String description, 
                                    @RequestParam("category") String category,
                                    @RequestParam("unitsInStock") String unitsInStock, 
                                    @RequestParam("condition") String condition,
                                    @RequestParam(value = "bookImage", required = false) MultipartFile file,
                                    HttpServletRequest request) throws IOException {

        //bookDao가 null인지 체크
        if (bookDao == null) {
            throw new RuntimeException("BookDao가 주입되지 않았습니다!");
        }

        //숫자 변환
        int price = unitPrice.isEmpty() ? 0 : Integer.parseInt(unitPrice);
        long stock = unitsInStock.isEmpty() ? 0 : Long.parseLong(unitsInStock);

        //기존 책 정보 조회
        Book book = bookDao.getBookById(bookId);
        if (book == null) {
            return "redirect:/bookmarket/editBook.do?edit=notfound";
        }

        //파일 저장 경로 확인
        String uploadDir = request.getServletContext().getRealPath("/images");
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            boolean created = dir.mkdirs();
            System.out.println("디렉토리 생성 여부: " + created);
        }

        //파일 업로드 확인
        String filename = file != null && !file.isEmpty() ? file.getOriginalFilename() : book.getFilename();
        if (file != null && !file.isEmpty()) {
            try {
                file.transferTo(new File(uploadDir, filename));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        //책 정보 업데이트
        book.setName(name);
        book.setUnitPrice(price);
        book.setAuthor(author);
        book.setPublisher(publisher);
        book.setReleaseDate(releaseDate);
        book.setDescription(description);
        book.setCategory(category);
        book.setUnitsInStock(stock);
        book.setCondition(condition);
        book.setFilename(filename);

        //DB 업데이트
        try {
            bookDao.updateBook(book);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/bookmarket/books.do";  
    }

	
	@RequestMapping("/bookmarket/exceptionNoBookId.do")
	public String exceptionNoBookId() {
		return "/exceptionNoBookId";
	}
	
	@RequestMapping("/bookmarket/deleteBook.do")
	public String deleteBook() {
		return "/deleteBook";
	}
	
	@RequestMapping("/bookmarket/book.do")
	public String book() {
		return "/book";
	}
	
	@RequestMapping("/bookmarket/cart.do")
	public String cart() {
		return "/cart";
	}
	
	@RequestMapping("/bookmarket/addCart.do")
	public String addCart() {
		return "/addCart";
	}
	
	@RequestMapping("/bookmarket/deleteCart.do")
	public String deleteCart() {
		return "/deleteCart";
	}
	
	@RequestMapping("/bookmarket/removeCart.do")
	public String removeCart() {
		return "/removeCart";
	}
	
	@RequestMapping("/bookmarket/shippingInfo.do")
	public String shippingInfo() {
		return "/shippingInfo";
	}
	
	@RequestMapping("/bookmarket/checkOutCancelled.do")
	public String checkOutCancelled() {
		return "/checkOutCancelled";
	}
	
	@RequestMapping("/bookmarket/processShippingInfo.do")
	public String processShippingInfo() {
		return "/processShippingInfo";
	}
	
	@RequestMapping("/bookmarket/orderConfirmation.do")
	public String orderConfirmation() {
		return "/orderConfirmation";
	}
	
	@RequestMapping("/bookmarket/thankCustomer.do")
	public String thankCustomer() {
		return "/thankCustomer";
	}
}







