package dbaccess;

import java.sql.*;

public class database {
	String connURL = "jdbc:mysql://localhost:3306/jaeproject?user=root&password=password&serverTimezone=UTC";
	Connection conn = null;

	// getUserDetails
	public users getUserDetails(String username, String password) throws SQLException {
		users uBean = new users();

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			String sqlstr = "SELECT * FROM user where username = ? and password = ?";
			PreparedStatement pstmt = conn.prepareStatement(sqlstr);
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			ResultSet rs = pstmt.executeQuery();
			Statement stmt = conn.createStatement();
			if (rs.next()) {
				String userid = rs.getString("userId");

				uBean.setUserId(userid);
				uBean.setUsername(rs.getString("username"));
				uBean.setEmail(rs.getString("email"));
				uBean.setPassword(rs.getString("password"));
				uBean.setRole(rs.getString("role"));
				uBean.setPhoneNumber(rs.getString("phoneNumber"));
				uBean.setDeliveryAddress(rs.getString("deliveryAddress"));
				uBean.setPostalCode(rs.getString("postalCode"));
				uBean.setPaymentType(rs.getString("paymentType"));
				uBean.setCardNumber(rs.getString("CardNumber"));
			}
		} catch (Exception e) {
			System.out.print(e);
		}

		conn.close();

		return uBean;
	}

	// check password
	public ResultSet GetAllCategories() throws SQLException {

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			String sqlstr = "SELECT * from productcategory";
			PreparedStatement pstmt = conn.prepareStatement(sqlstr);
			ResultSet rs = pstmt.executeQuery();
			Statement stmt = conn.createStatement();

			return rs;

		} catch (Exception e) {
			System.out.print(e);
		}

		conn.close();

		return null;
	}

	public ResultSet MainPageSql() throws SQLException {

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			PreparedStatement pstmt = conn.prepareStatement("select * from product");
			ResultSet rs = pstmt.executeQuery();
			Statement stmt = conn.createStatement();

			return rs;

		} catch (Exception e) {
			System.out.print(e);
		}

		conn.close();

		return null;
	}

	public ResultSet HeadersSql() throws SQLException {

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			PreparedStatement pstmt = conn.prepareStatement("SELECT DISTINCT CategoryName FROM productcategory");
			ResultSet rs = pstmt.executeQuery();
			// Statement stmt = conn.createStatement();

			return rs;
		} catch (Exception e) {
			System.out.println(e);
		}
		conn.close();

		return null;
	}

	public ResultSet ListProductSql(String category) throws SQLException {

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			PreparedStatement pstmt = null;
			if (category.equals("nothing") || category.equals("all")) {
				pstmt = conn.prepareStatement("SELECT * FROM product");
			} else {
				pstmt = conn.prepareStatement("SELECT * FROM product WHERE `CategoryName` = ?");
				pstmt.setString(1, category);
			}

			ResultSet rs = pstmt.executeQuery();

			return rs;
		} catch (Exception e) {
			System.out.println(e);
		}
		conn.close();

		return null;
	}

	public ResultSet SearchSql(String input) throws SQLException {

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			PreparedStatement pstmt = null;
			pstmt = conn.prepareStatement("SELECT * FROM product WHERE ProductName like ? ");
			pstmt.setString(1, "%" + input + "%");

			ResultSet rs = pstmt.executeQuery();
			conn.close();
			return rs;
		} catch (Exception e) {
			System.out.println(e);
		}
		conn.close();
		return null;
	}

	public boolean RegisterLogic(String username, String email, String password, String phoneNumber,
			String deliveryAddress, String postalCode, String paymentType, String cardNumber) throws SQLException {

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			PreparedStatement pstmt = null;
			pstmt = conn.prepareStatement(
					"Insert into user(username,email,password,role,phoneNumber,deliveryAddress,postalCode,paymentType,cardNumber) values(?,?,?,?,?,?,?,?,?)");
			pstmt.setString(1, username);
			pstmt.setString(2, email);
			pstmt.setString(3, password);
			pstmt.setString(4, "customer");
			pstmt.setInt(5, Integer.parseInt(phoneNumber));
			pstmt.setString(6, deliveryAddress);
			pstmt.setString(7, postalCode);
			pstmt.setString(8, paymentType);
			pstmt.setInt(9, Integer.parseInt(cardNumber));

			int number = pstmt.executeUpdate();
			if (number > 0) {
				System.out.println(number + " user added!");
				// conn.close();
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		conn.close();
		return false;
	}

	public ResultSet EditProductSql(String itemId) throws SQLException {

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			PreparedStatement pstmt = null;
			pstmt = conn.prepareStatement("SELECT * from product where `productId` = ?");
			pstmt.setString(1, itemId);

			ResultSet rs = pstmt.executeQuery();
			conn.close();

			return rs;
		} catch (Exception e) {
			e.printStackTrace();
		}
		conn.close();
		return null;
	}

	public ResultSet getQuantityInCart(String id, String itemId) throws SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			Statement stmt = conn.createStatement();
			PreparedStatement ptsmt;
			ptsmt = conn.prepareStatement("Select itemQuantity from cart where productId=? and buyerId=?");
			ptsmt.setInt(1, Integer.parseInt(itemId));
			ptsmt.setInt(2, Integer.parseInt(id));
			ResultSet rs = ptsmt.executeQuery();
			return rs;

		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
		return null;
	}

	public void UpdateCustomerProfileSql(String id, String phonenumber,
			String deliveryAddress, String postalCode, String paymentType, String cardNumber) {
		try {			
			/*
			 * System.out.println(id); System.out.println(phonenumber);
			 * System.out.println(deliveryAddress); System.out.println(postalCode);
			 * System.out.println(paymentType); System.out.println(cardNumber);
			 */
			
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			PreparedStatement pstmt = null;
			pstmt = conn.prepareStatement(
					"Update user set phonenumber=?, deliveryAddress=?, postalCode=?, paymentType= ? , cardNumber= ? where userId = ?");						
			pstmt.setString(1, phonenumber);
			pstmt.setString(2, deliveryAddress);
			pstmt.setString(3, postalCode);
			pstmt.setString(4, paymentType);
			pstmt.setString(5, cardNumber);
			pstmt.setString(6, id);

			int number = pstmt.executeUpdate();
			if (number > 0)
				System.out.println(number + " records updated!");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public String getConnURL() {
		return connURL;
	}

	public void setConnURL(String connURL) {
		this.connURL = connURL;
	}
}