package dbaccess;

import java.sql.*;
import models.users;

public class database {
	// String connURL =
	// "jdbc:mysql://us-cdbr-east-02.cleardb.com/heroku_74e134f8b35c7fb?user=b3f5d9ea8a0e54&password=59c9e3b1&serverTimezone=UTC";
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

	//
	public ResultSet GetAllCategories() throws SQLException {

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			String sqlstr = "SELECT * from productcategory";
			PreparedStatement pstmt = conn.prepareStatement(sqlstr);
			ResultSet rs = pstmt.executeQuery();

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
			PreparedStatement pstmt = conn.prepareStatement("SELECT CategoryName FROM productcategory");
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

			return rs;
		} catch (Exception e) {
			e.printStackTrace();
		}
		conn.close();
		return null;
	}

	public int getQuantityInCart(String id, String itemId) throws SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			PreparedStatement ptsmt;
			ptsmt = conn.prepareStatement(
					"SELECT cd.itemQuantity from cart c, cartDetails cd where cd.productId = ? and c.userId=? and c.status='viewing'");
			ptsmt.setInt(1, Integer.parseInt(itemId));
			ptsmt.setInt(2, Integer.parseInt(id));
			ResultSet rs = ptsmt.executeQuery();
			rs.next();
			return Integer.parseInt(rs.getString("itemQuantity"));

		} catch (Exception e) {
			System.err.println("Error :" + e);
		}
		return 0;
	}

	public void UpdateCustomerProfileSql(String id, String phonenumber, String deliveryAddress, String postalCode,
			String paymentType, String cardNumber) throws SQLException {
		try {

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

	public ResultSet EditProduct2(String productName, String Description, String DetailDescription, String price,
			String Stock, String ProductCategory, String ImageLocation, String itemId) throws SQLException {
		System.out.println(productName);
		System.out.println(Description);
		System.out.println(DetailDescription);
		System.out.println(price);
		System.out.println(Stock);
		System.out.println(ProductCategory);
		System.out.println(ImageLocation);
		System.out.println(itemId);

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			PreparedStatement ptsmt = null;
			ptsmt = conn.prepareStatement(
					"Update product set ProductName= ?,Description =?,DetailDescription =?,RetailPrice =?,StockQuantity =?,ImageLocation =? where productId=?");
			ptsmt.setString(1, productName);
			ptsmt.setString(2, Description);
			ptsmt.setString(3, DetailDescription);
			ptsmt.setFloat(4, Float.parseFloat(price));
			ptsmt.setInt(5, Integer.parseInt(Stock));
			ptsmt.setString(6, ImageLocation);
			ptsmt.setInt(7, Integer.parseInt(itemId));
			int number = ptsmt.executeUpdate();

			if (number > 0)
				System.out.println(number + " records updated!");

		} catch (Exception e) {
			System.out.println("here22222");
			System.err.println("Error :" + e);
		}

		return null;
	}

	public void deleteProductSql(String productId) throws SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			PreparedStatement pstmt = conn.prepareStatement("DELETE FROM product where productId = ?");
			pstmt.setString(1, productId);
			int number = pstmt.executeUpdate();

			if (number > 0) {
				System.out.println(productId + " account deleted!");
			}
		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	public String getConnURL() {
		return connURL;
	}

	public ResultSet IndividualAccountSql() throws SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM user");
			ResultSet rs = pstmt.executeQuery();
			return rs;

		} catch (Exception e) {
			System.out.println("error getting individual account info");
			e.printStackTrace();
		}
		return null;
	}

	public ResultSet getNoOfDistinctRoles() throws SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			PreparedStatement pstmt = conn
					.prepareStatement("SELECT COUNT(distinct role) as 'total_no_of_rows' from user");
			ResultSet rs = pstmt.executeQuery();
			return rs;
		} catch (Exception e) {
			System.out.println("error getting cont of distinct roles");
			e.printStackTrace();
		}

		return null;
	}

	public ResultSet getColumnNamesSql() throws SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			PreparedStatement pstmt = conn.prepareStatement(
					"SELECT COLUMN_NAME 'Column' FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA ='jaeproject' AND TABLE_NAME = 'product' ORDER BY ORDINAL_POSITION");
			ResultSet rs = pstmt.executeQuery();
			return rs;
		} catch (Exception e) {
			System.out.println("error getting cont of distinct roles");
			e.printStackTrace();
		}

		return null;
	}

	public void updateAccountSql(String userId, String role, String buttonType) throws SQLException {
		try {
			System.out.println(buttonType);
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			String sqlString = "";
			PreparedStatement pstmt = null;

			if (buttonType.equals("Update")) {
				sqlString = "Update user set role=? where userId=?";
				pstmt = conn.prepareStatement(sqlString);
				pstmt.setString(1, role);
				pstmt.setString(2, userId);
			} else {
				sqlString = "DELETE from user where userId =?";
				pstmt = conn.prepareStatement(sqlString);
				pstmt.setString(1, userId);
			}

			int number = pstmt.executeUpdate();
			if (number > 0) {
				System.out.println(userId + " updated!");
			}

		} catch (Exception e) {
			System.out.println("error updating acount through root page");
			e.printStackTrace();
		}
	}

	public void newCategorySql(String newCategoryName, String type, String oldCategoryName) throws SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			PreparedStatement pstmt = null;
			String sqlString = "";
			if (type.equals("null")) {
				sqlString = "INSERT into productCategory values(?)";
			} else {
				sqlString = "UPDATE productCategory set categoryName=? where Categoryname = ?";
			}
			pstmt = conn.prepareStatement(sqlString);
			pstmt.setString(1, newCategoryName);
			pstmt.setString(2, oldCategoryName);

			pstmt.executeUpdate();
			System.out.println("new category added! : " + newCategoryName);

		} catch (Exception e) {
			System.out.println("failed to add new categoroy named " + newCategoryName);
			e.printStackTrace();
		}
	}

	public ResultSet GetRoles() throws SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			PreparedStatement pstmt = null;
			pstmt = conn.prepareStatement("SELECT DISTINCT role FROM user");

			ResultSet rs = pstmt.executeQuery();

			return rs;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public void addProductLogic(String productName, String Description, String DetailDescription, String price,
			String Stock, String categoryName, String ImageLocation) throws SQLException {

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			PreparedStatement ptsmt;
			ptsmt = conn.prepareStatement(
					"INSERT INTO product(ProductName,Description,DetailDescription,costPrice,RetailPrice,DiscountPrice,StockQuantity,CategoryName,ImageLocation) values(?,?,?,?,?,?,?,?,?)");
			ptsmt.setString(1, productName);
			ptsmt.setString(2, Description);
			ptsmt.setString(3, DetailDescription);
			ptsmt.setFloat(4, Float.parseFloat(price));
			ptsmt.setFloat(5, Float.parseFloat(price));
			ptsmt.setFloat(6, Float.parseFloat(price));
			ptsmt.setInt(7, Integer.parseInt(Stock));
			ptsmt.setString(8, categoryName);
			ptsmt.setString(9, ImageLocation);
			int number = ptsmt.executeUpdate();
			if (number > 0)
				System.out.println(number + " records inserted");

		} catch (Exception e) {
			System.out.println("creating a new product");
			e.printStackTrace();
		}
	}

	public ResultSet currentCartCountSql(String userId) throws SQLException {

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			PreparedStatement pstmt = conn.prepareStatement(
					"select count(*) as count from cartDetils cd, Cart c were cd.cartId= c.cartId and userid=? and status='viewing'");
			pstmt.setString(1, userId);

			ResultSet rs = pstmt.executeQuery();
			return rs;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ResultSet currentCartSql(String userId) throws SQLException {

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			PreparedStatement pstmt = conn.prepareStatement(
					"select p.productID, p.ProductName,p.ImageLocation, p.Retailprice, cd.itemQuantity from product p, cart c, cartdetails cd where cd.productId=p.productId and c.cartId=cd.cartId and c.status = 'viewing' and c.userId=?");
			pstmt.setString(1, userId);

			ResultSet rs = pstmt.executeQuery();
			return rs;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ResultSet currentCartSql2(String userId) throws SQLException {

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL);
			PreparedStatement pstmt = conn.prepareStatement(
					"select count(*) as count, p.productID, p.ProductName,p.ImageLocation, p.Retailprice, cd.itemQuantity from product p, cart c, cartdetails cd where cd.productId=p.productId and c.cartId=cd.cartId and c.status = 'viewing' and c.userId=?");
			pstmt.setString(1, userId);

			ResultSet rs = pstmt.executeQuery();
			return rs;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ResultSet OverallInventorySql() throws SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(connURL);
			PreparedStatement pstmt = conn.prepareStatement("select count(productId) as totalNumberOfProducts,(sum(stockquantity)) as totalStockQuantity ,(sum(costPrice*stockquantity)) as totalCostPrice from product");
			
			ResultSet rs = pstmt.executeQuery();
			return rs;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ResultSet totalProductsInCategory() throws SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(connURL);
			PreparedStatement pstmt = conn.prepareStatement("select categoryName, sum(stockquantity) as totalStockQuantity from product group by categoryName");
			
			ResultSet rs = pstmt.executeQuery();
			return rs;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ResultSet top4Products() throws SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(connURL);
			PreparedStatement pstmt = conn.prepareStatement("select p.productId, count(cd.productId) as count,p.productName from cartdetails cd, product p,cart c where p.productId= cd.productId and cd.cartId= c.cartId group by cd.productId order by count desc limit 4");
			
			ResultSet rs = pstmt.executeQuery();
			return rs;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ResultSet TotalSalesDistribution() throws SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(connURL);
			PreparedStatement pstmt = conn.prepareStatement("select p.categoryName, sum(cd.itemQuantity*cd.priceEach) as totalProfitsFromCategory from product p,cartdetails cd where cd.productId=p.productId group by p.categoryName",
					ResultSet.TYPE_SCROLL_INSENSITIVE,
				    ResultSet.CONCUR_READ_ONLY);
			
			ResultSet rs = pstmt.executeQuery();
			return rs;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ResultSet Least4Products() throws SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(connURL);
			PreparedStatement pstmt = conn.prepareStatement("select  p.productId, count(cd.productId) as count,p.productName from cartdetails cd, product p,cart c where p.productId= cd.productId and cd.cartId= c.cartId group by cd.productId order by count asc limit 4");
			
			ResultSet rs = pstmt.executeQuery();
			return rs;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ResultSet checkCartSql(String id,String itemId) throws SQLException {
		try {			
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(connURL);
			PreparedStatement pstmt = conn.prepareStatement("Select * from cart c, cartDetails cd where c.userId=? and cd.productId=? and status='viewing'");			
			pstmt.setInt(1, Integer.parseInt(id));
			pstmt.setInt(2, Integer.parseInt(itemId));		
			ResultSet rs = pstmt.executeQuery();			
			
			return rs;
			
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return null;
	}
	
	public void addToCartSql(String currentQuantity,String id,String itemId,String currentCartId,String quantity,String priceEach)  throws SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(connURL);
			PreparedStatement pstmt=null;
			
			if(currentCartId != "null") {
				int newQuantity = Integer.parseInt(currentQuantity)+Integer.parseInt(quantity);
				pstmt=conn.prepareStatement("Update cartdetails set productId=?, itemQuantity =?,priceEach=? where CartId=? and productId=?");
				pstmt.setString(1,itemId);
				pstmt.setInt(2,newQuantity);
				pstmt.setString(3,priceEach);
				pstmt.setString(4,currentCartId);
				pstmt.setString(5,itemId);
				
				
				int number = pstmt.executeUpdate();
				if (number > 0)
					System.out.println(number+" record updated!");
			}else {
				pstmt=conn.prepareStatement("Insert into cart(status,userId) values('viewing',?)");
				pstmt.setString(1, id);
				int number = pstmt.executeUpdate();
				if (number > 0) {
					System.out.println("Insert into cart number: "+number);	
					PreparedStatement pstmt2= conn.prepareStatement("select cartId from cart where userId=? and status= 'viewing'");
					pstmt2.setString(1,id);
					ResultSet rs=pstmt2.executeQuery();
					rs.next();					
					String newCartId=rs.getString("cartId");
					if(number>0) {
						System.out.println("new cartId: "+newCartId);
						PreparedStatement pstmt3=conn.prepareStatement("Insert into cartdetails(cartId,productId,itemQuantity,PriceEach) values(?,?,?,?)");
						pstmt3.setString(1, newCartId);
						pstmt3.setString(2, itemId);
						pstmt3.setString(3, quantity);
						pstmt3.setString(4, priceEach);
						number=pstmt3.executeUpdate();
						if(number>0) {
							System.out.println("Record Inserted!");
						}else {
							System.out.println("error 3");
						}
						
					}else {
						System.out.println("error 2");
					}
				}
				
				
				//PreparedStatement pstmt2=conn.prepareStatement("Insert into cartdetails(");
			}
			
			
			
			
			
		//"Update user set phonenumber=?, deliveryAddress=?, postalCode=?, paymentType= ? , cardNumber= ? where userId = ?");			
			
			
			
			
		} catch (Exception e) {
			//System.err.println("Error :" + e);
		}	
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/////////////////////////////////////

	public void setConnURL(String connURL) {
		this.connURL = connURL;
	}
}