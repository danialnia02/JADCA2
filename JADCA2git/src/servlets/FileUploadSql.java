package servlets;

import java.io.File;
import java.util.List;
import java.io.IOException;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import dbaccess.database;

/**
 * Servlet implementation class FileUploadSql
 */
@WebServlet("/FileUploadSql")
public class FileUploadSql extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FileUploadSql() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		String productName = "", description = "", ProductId = "", DetailDescription = "", Price = "",
				categoryName = "", stock = "", imgURL = "";

		try {
			List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);

			for (FileItem item : multiparts) {
				if (!item.isFormField()) {
					String name = new File(item.getName()).getName();					
					item.write(new File(this.getServletContext().getRealPath("/CA1/img") + File.separator + name));
					imgURL = "img/" + name;
				} else {
					switch (item.getFieldName()) {
					case "productName":
						productName = item.getString();
						break;
					case "description":
						description = item.getString();
						break;
					case "DetailDescription":
						DetailDescription = item.getString();
						break;
					case "Price":
						Price = item.getString();
						break;
					case "categoryName":
						categoryName = item.getString();
						break;
					case "stock":  
						stock = item.getString();
						break;
					case "ProductId":
						ProductId = item.getString();
						break;
					}
				}
			}
			database udatabase = new database();
			ResultSet rs = udatabase.EditProduct2(productName, description, DetailDescription, Price, stock,
					categoryName, imgURL, ProductId);
			request.setAttribute("FileUploadSql", rs);
			response.sendRedirect("/JADCA2git/CA1/MainPage.jsp");

		} catch (Exception e) {
			System.out.println("error uploading Image");
			e.printStackTrace();
		}

		/*
		 * try { ServletFileUpload sf = new ServletFileUpload(new
		 * DiskFileItemFactory()); List<FileItem> multifiles = sf.parseRequest(request);
		 * 
		 * for (FileItem item : multifiles) { item.write(new File(
		 * "C:\\j2ee\\files\\jadca2folder\\JADCA2\\JADCA2git\\WebContent\\CA1\\images\\"
		 * + item.getName())); } } catch (Exception e) {
		 * System.out.println("error uploading Image"); e.printStackTrace(); }
		 */
		// System.out.println("file uplodaded");
	}

}
