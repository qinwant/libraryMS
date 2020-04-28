package com.kingwan.utils;

import com.mchange.v2.c3p0.ComboPooledDataSource;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GokJDBCUtil {
	/**
	 * 驱动名
	 */
	public static final String DRIVER_CLASS_NAME = "com.mysql.jdbc.Driver";
	/**
	 * 连接数据库地址
	 */
	public static final String URL = "jdbc:mysql://localhost:3306/libraryms?useUnicode=true&characterEncoding=UTF-8&useSSL=false";
	/**
	 * 数据库用户名
	 */
	public static final String USERNAME = "root";
	/**
	 * 数据库密码
	 */
	public static final String PASSWORD = "toor";
	/**
	 * 构造方法私有化
	 */
	private GokJDBCUtil() {
	}

	/**
	 * 获取数据连接
	 * 
	 * @return
	 */
//	public static Connection getConnection() {
//		try {
//			// 加载驱动
//			Class.forName(DRIVER_CLASS_NAME);
//			// 2.获取连接
//			return DriverManager.getConnection(URL, USERNAME, PASSWORD);
//		} catch (ClassNotFoundException e) {
//			e.printStackTrace();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return null;
//
//	}
	//使用数据库连接池
	private static ComboPooledDataSource dataSource = null;
	public static Connection getConnection() {
		try {
			// 加载驱动
			 dataSource = new ComboPooledDataSource("testc3p0");

//			dataSource = new ComboPooledDataSource("testc3p0");
			// 2.获取连接
			Connection connection = dataSource.getConnection();
			return connection;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;

	}

	/**
	 * 关闭相关资源
	 * 
	 * @param con
	 *            数据库链接
	 * @param st
	 *            查询接口
	 * @param rs
	 *            结果集
	 */
	public static void close(Connection con, Statement st, ResultSet rs) {
		try {
			try {
				if (rs != null) {
					rs.close();

					rs = null;
				}
			} finally {
				try {
					if (st != null) {
						st.close();

						st = null;
					}
				} finally {
					if (con != null) {
						con.close();

						con = null;
					}
					dataSource.close();
				}
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * 查询指定sql的结果集记录数，返回值为int类型
	 * 
	 * @param sql
	 *            查询sql
	 * @param args
	 *            sql中带条件字段值
	 * @return 返回记录数
	 */
	public static int queryForCount(String sql, Object... args) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			ps = con.prepareStatement(sql);
			for (int i = 0; args != null && i < args.length; i++) {
				ps.setObject(i + 1, args[i]);
			}
			rs = ps.executeQuery();
			while (rs.next()) {
				// 返回第一行第一列
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(con, ps, rs);
		}
		return 0;
	}

	/**
	 * 查询指定sql，将查询结果集的每条记录封装成指定类型对象，返回类型为List
	 * <br/>
	 * 表的字段数据类型必须和类的属性数据类型一致 表的字段名字必须和类的属性名字一致
	 * 
	 * @param sql
	 *            查询sql
	 * @param c
	 *            指定封装类类型
	 * @param args
	 *            sql中带条件字段值
	 * @return 返回查询结果记录集合List
	 */
	public static <T> List<T> queryAll(String sql, Class<T> c, Object... args) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<T> list = null;
		try {
			con = getConnection();
			ps = con.prepareStatement(sql);
			for (int i = 0; args != null && i < args.length; i++) {
				ps.setObject(i + 1, args[i]);
			}
			rs = ps.executeQuery();
			// 通过反射获取类的所有属性
			Field fields[] = c.getDeclaredFields();
			list = new ArrayList<T>();
			ResultSetMetaData rsmd = rs.getMetaData();
			while (rs.next()) {
				// 根据类实例化对象
				T o = c.newInstance();
				/**
				 * 对象的属性赋值，需要调用set方法，需要获取set方法对象，需要知道set方法名字
				 */
				for (int i = 0; i < fields.length; i++) {
					// 获取每一个字段
					Field field = fields[i];
					// 获取字段名字
					String fieldName = field.getName();// id--setI d
					// 获取字段类型
					Class<?> fieldType = field.getType();
					// 获取set方法名
					String methodName = "set" + (fieldName.charAt(0) + "").toUpperCase() + fieldName.substring(1);
					// 获取set方法对象
					Method method = c.getMethod(methodName, fieldType);

					/**
					 * 注意点: 1.如果查询的结果的字段名和属性名不一样会报错User(id,name,password) select id,name from t_user
					 * 2.查询结果某一行数据为空的时候会报错 3.在oralce：value获取的数据类型和实体列中的数据类型可能匹配不上
					 * 如果oralce中是数字类型，value获取的数据类型不是int类型
					 */
					// 判断字段是否在结果集中存在
					if (isExists(rsmd, fieldName)) {// fieldName=category
						// 根据类的属性名字获取字段的值
						Object value = rs.getObject(fieldName);
						if (value != null) {
							// 调用set方法，对象中的属性赋值
							method.invoke(o, value);

						}

					}

				}
				// 需要把对象放到List中，然后返回list

				list.add(o);
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			close(con, ps, rs);
		}

		return list;
	}

	/**
	 * 判断实体类中的属性是否在结果集中存在
	 * 
	 * @param rsmd
	 *            结果集的元信息
	 * @param fieldName
	 *            实体类的属性
	 * @return
	 */
	private static boolean isExists(ResultSetMetaData rsmd, String fieldName) {

		try {
			int count = rsmd.getColumnCount();
			for (int i = 0; i < count; i++) {
				// 获取每列的字段名字,字段的下标从1开始
				String columnName = rsmd.getColumnLabel(i + 1);
				if (columnName.equals(fieldName)) {
					return true;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;

	}

	/**
	 * 查询指定sql单条记录，返回指定对象类型数据
	 * 
	 * @param sql  指定sql
	 * @param c
	 *            对象的类型
	 * @param args
	 * @return
	 */
	public static <T> T queryForObject(String sql, Class<T> c, Object... args) {
		List<T> list = queryAll(sql, c, args);
		if (list != null && list.size() > 0) {
			return list.get(0);
		}
		return null;

	}

	/**
	 * <p>
	 * 对表的增删改功能的统一调用此方法
	 * </p>
	 * 
	 * @param sql
	 *            需要执行的SQL语句
	 * @param args
	 *            动态参数
	 * @return 受影响的行数；如果没有修改、删除、新增数据，返回0
	 */
	public static int update(String sql, Object... args) {
		Connection con = null;

		PreparedStatement ps = null;
		try {
			// 获取连接
			con = getConnection();
			// 创建statement对象
			ps = con.prepareStatement(sql);

			// 设置参数
			for (int i = 0; args != null && i < args.length; i++) {
				ps.setObject(i + 1, args[i]);
			}

			// 执行SQL语句
			return ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 关闭资源
			close(con, ps, null);
		}
		return 0;

	}

	public static void main(String[] args) {
		System.out.println(GokJDBCUtil.getConnection());
	}

}
