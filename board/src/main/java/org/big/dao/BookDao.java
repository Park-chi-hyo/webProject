package org.big.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.big.common.DBConnection;
import org.big.dto.Book;
import org.springframework.stereotype.Repository;

@Repository
public class BookDao {

    // 책 정보를 DB에 삽입하는 메소드
    public void insertBook(Book book) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        String sql = "INSERT INTO book (b_id, b_name, b_unitPrice, b_author, b_description, b_publisher, b_category, b_unitsInStock, b_releaseDate, b_condition, b_filename) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            conn = DBConnection.getConnection();  // DB 연결
            pstmt = conn.prepareStatement(sql);

            // 쿼리 파라미터 설정
            pstmt.setString(1, book.getBookId());
            pstmt.setString(2, book.getName());
            pstmt.setInt(3, book.getUnitPrice());
            pstmt.setString(4, book.getAuthor());
            pstmt.setString(5, book.getDescription());
            pstmt.setString(6, book.getPublisher());
            pstmt.setString(7, book.getCategory());
            pstmt.setLong(8, book.getUnitsInStock());
            pstmt.setString(9, book.getReleaseDate());
            pstmt.setString(10, book.getCondition());
            pstmt.setString(11, book.getFilename());

            // 실행
            pstmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();  // 예외 처리
        } finally {
            // 자원 해제
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public Book getBookById(String bookId) {
        String sql = "SELECT * FROM book WHERE b_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, bookId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getString("b_id"));
                book.setName(rs.getString("b_name"));
                book.setUnitPrice(rs.getInt("b_unitPrice"));
                book.setAuthor(rs.getString("b_author"));
                book.setPublisher(rs.getString("b_publisher"));
                book.setReleaseDate(rs.getString("b_releaseDate"));
                book.setDescription(rs.getString("b_description"));
                book.setCategory(rs.getString("b_category"));
                book.setUnitsInStock(rs.getLong("b_unitsInStock"));
                book.setCondition(rs.getString("b_condition"));
                book.setFilename(rs.getString("b_filename"));

                return book;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 책 정보 업데이트 메서드
    public void updateBook(Book book) {
        String sql = "UPDATE book SET b_name=?, b_unitPrice=?, b_author=?, b_description=?, b_publisher=?, b_category=?, b_unitsInStock=?, b_releaseDate=?, b_condition=?, b_filename=? WHERE b_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, book.getName());
            pstmt.setInt(2, book.getUnitPrice());
            pstmt.setString(3, book.getAuthor());
            pstmt.setString(4, book.getDescription());
            pstmt.setString(5, book.getPublisher());
            pstmt.setString(6, book.getCategory());
            pstmt.setLong(7, book.getUnitsInStock());
            pstmt.setString(8, book.getReleaseDate());
            pstmt.setString(9, book.getCondition());
            pstmt.setString(10, book.getFilename());
            pstmt.setString(11, book.getBookId());

            pstmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
