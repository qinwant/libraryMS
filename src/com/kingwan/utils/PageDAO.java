package com.kingwan.utils;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
/**
 * Created by kingwan on 2020/4/5.
 */

/**
 *
 * @author Administrator 分页封装类
 */
public class PageDAO {
    // 以下三个常量代表分页工具条的样式。
    public static final String Text = "text";

    public static final String BbsText = "bbstext";

    public static final String BbsImage = "bbsimage";

    private HttpServletRequest request;

    private int currentpage = 1; // 当前是第几页

    private int pagecount = 0; // 一共有多少页

    private int rscount = 0; // 一共有多少行表示一共有多少条数据

    private int pagesize = 20; // 每页有多少行[默认为20行]

    public PageDAO(HttpServletRequest request) {
        this.request = request;
    }

    public void setCurrentpage(int currentpage) {
        this.currentpage = currentpage;
    }

    public void setPagecount(int pagecount) {
        this.pagecount = pagecount;
    }

    public int getPagesize() {
        return pagesize;
    }

    public void setPagesize(int pagesize) {
        this.pagesize = pagesize;
    }

    public int getRscount() {
        return rscount;
    }

    public void setRscount(int rscount) {
        this.rscount = rscount;
    }

    /**
     * 获取总页数
     *
     * @return int
     */
    public int getPageCount() {
        try {
            //this.rscount 总记录数
            //this.pagesize当前页面条数
            this.pagecount = ((this.rscount - 1) / this.pagesize) + 1;
        } catch (Exception ex) {
            this.pagecount = 0;
        }
        return this.pagecount;
    }

    /**
     * 获取当前页码的设置
     *
     * @return int
     */
    public int getCurrentPage() {
        try {
            if (this.request.getParameter("currentpage") != null
                    && Integer.parseInt(this.request.getParameter("currentpage")) > 1) {
                this.currentpage = Integer.parseInt(this.request.getParameter("currentpage"));
            } else {
                this.currentpage = 1;
            }
        } catch (Exception ex) {
            this.currentpage = 1;
        }
        return this.currentpage;
    }

    /**
     * 分页工具条
     *
     * @param fileName
     *            String
     * @return String
     */
    public String pagetool(String flag) {
        // 计算总页数
        getPageCount();
        StringBuffer str = new StringBuffer();
        String temp = "";
        // 智能解析请求的参数列表
        String url = this.getParamUrl();
        int ProPage = this.currentpage - 1;
        int Nextpage = this.currentpage + 1;
        // 文字的分页
        if (flag.equals(PageDAO.Text)) {
            str.append("<form method='post' name='pageform' action=''>");
            str.append("<table width='100%' border='0' cellspacing='0' cellpadding='0'>");
            str.append("<tr>");
            str.append("<td height='26' align='center'>");
            str.append("共有记录" + this.rscount + "条&nbsp;&nbsp;");
            str.append("共" + this.pagecount + "页&nbsp;&nbsp;");
            str.append("每页" + this.pagesize + "记录&nbsp;&nbsp;");
            str.append("现在" + this.currentpage + "/" + this.pagecount + "页");
            str.append("&nbsp;&nbsp;");
            if (this.currentpage > 1) {
                str.append("<a href='" + url + "&currentpage=1'>首页</a>");
                str.append("&nbsp;");
                str.append("<a href='" + url + "&currentpage=" + ProPage + "'>上一页</a>");
                str.append("&nbsp;&nbsp;");
            } else {
                str.append("首页");
                str.append("&nbsp;&nbsp;");
                str.append("上一页");
                str.append("&nbsp;&nbsp;");
            }
            if (this.currentpage < this.pagecount) {
                str.append("<a href='" + url + "&currentpage=" + Nextpage + "'>下一页</a>");
                str.append("&nbsp;&nbsp;");
            } else {
                str.append("下一页");
                str.append("&nbsp;&nbsp;");
            }
            if (this.pagecount > 1 && this.currentpage != this.pagecount) {
                str.append("<a href='" + url + "&currentpage=" + pagecount + "'>尾页</a>");
                str.append("&nbsp;&nbsp;");
            } else {
                str.append("尾页");
                str.append("&nbsp;&nbsp;");
            }
            str.append("转到");
            str.append("<select name='currentpage' onchange='javascript:ChangePage(this.value);'>");
            for (int j = 1; j <= pagecount; j++) {
                str.append("<option value='" + j + "'");
                if (currentpage == j) {
                    str.append("selected");
                }
                str.append(">");
                str.append("" + j + "");
                str.append("</option>");
            }
            str.append("</select>页");
            str.append("</td></tr></table>");
            str.append("<script language='javascript'>");
            str.append("function ChangePage(testpage){");
            str.append("document.pageform.action='" + url + "&currentpage='+testpage+'';");
            str.append("document.pageform.submit();");
            str.append("}");
            str.append("</script>");
            str.append("</form>");

        } else if (flag.equals(PageDAO.BbsText)) {
            /**
             * 论坛形式的分页[直接以数字方式体现]
             */
            str.append("<table width='100%' border='0' cellspacing='0' cellpadding='0'>");
            str.append("<tr>");
            str.append("<td width='3%'>&nbsp;</td>");
            str.append("<td height='26' align='center'>");
            str.append("记录" + this.rscount + "条&nbsp;&nbsp;");
            str.append("共" + this.pagecount + "页&nbsp;&nbsp;");
            str.append("每页" + this.pagesize + "记录&nbsp;&nbsp;");
            str.append("现在" + this.currentpage + "/" + this.pagecount + "页");
            str.append("</td><td>");
            // 设定是否有首页的链接
            if (this.currentpage > 1) {
                str.append("<a href='" + url + "&currentpage=1'>首页</a>");
                str.append("&nbsp;&nbsp;");
            }
            // 设定是否有上一页的链接
            if (this.currentpage > 1) {
                str.append("<a href='" + url + "&currentpage=" + ProPage + "'>上一页</a>");
                str.append("&nbsp;&nbsp;&nbsp;");
            }
            // 如果总页数只有10的话
            if (this.pagecount <= 10) {
                for (int i = 1; i <= this.pagecount; i++) {
                    if (this.currentpage == i) {
                        str.append("<font color=red>[" + i + "]</font>&nbsp;&nbsp;");
                    } else {
                        str.append("<a href='" + url + "&currentpage=" + i + "'>" + i + "</a>&nbsp;&nbsp;");
                    }
                }
            } else {
                // 说明总数有超过10页
                // 制定特环的开始页和结束页

                int endPage = this.currentpage + 4;
                if (endPage > this.pagecount) {
                    endPage = this.pagecount;
                }
                int startPage = 0;
                if (this.pagecount >= 8 && this.currentpage >= 8) {
                    startPage = this.currentpage - 5;
                } else {
                    // 表示从第一页开始算
                    startPage = 1;
                }
                System.out.println(startPage);
                System.out.println(endPage);
                for (int i = startPage; i <= endPage; i++) {
                    if (this.currentpage == i) {
                        str.append("<font color=red>[" + i + "]</font>&nbsp;&nbsp;");
                    } else {
                        str.append("<a href='" + url + "&currentpage=" + i + "'>" + i + "</a>&nbsp;&nbsp;");
                    }
                }
            }
            // 设定是否有下一页的链接
            if (this.currentpage < this.pagecount) {
                str.append("<a href='" + url + "&currentpage=" + Nextpage + "'>下一页</a>");
                str.append("&nbsp;&nbsp;");
            }
            // 设定是否有尾页的链接
            if (this.pagecount > 1 && this.currentpage != this.pagecount) {
                str.append("<a href='" + url + "&currentpage=" + pagecount + "'>尾页</a>");
                str.append("&nbsp;&nbsp;");
            }

            str.append("</td><td width='3%'>&nbsp;</td></tr></table>");
        } else if (flag.equals(PageDAO.BbsImage)) {
            /**
             * 论坛形式的分页[以图片的方式体现]
             */
            // 设定分页显示的CSS
            str.append("<style>");

            str.append(
                    "DIV.meneame {PADDING-RIGHT: 3px; PADDING-LEFT: 3px; FONT-SIZE: 80%; PADDING-BOTTOM: 3px; MARGIN: 3px; COLOR: #ff6500; PADDING-TOP: 3px; TEXT-ALIGN: center;}");
            str.append(
                    "DIV.meneame A {BORDER-RIGHT: #ff9600 1px solid; PADDING-RIGHT: 7px; BACKGROUND-POSITION: 50% bottom; BORDER-TOP: #ff9600 1px solid; PADDING-LEFT: 7px; BACKGROUND-IMAGE: url('"
                            + this.request.getContextPath()
                            + "/meneame.jpg'); PADDING-BOTTOM: 5px; BORDER-LEFT: #ff9600 1px solid; COLOR: #ff6500; MARGIN-RIGHT: 3px; PADDING-TOP: 5px; BORDER-BOTTOM: #ff9600 1px solid; TEXT-DECORATION: none}");
            str.append(
                    "DIV.meneame A:hover {BORDER-RIGHT: #ff9600 1px solid; BORDER-TOP: #ff9600 1px solid; BACKGROUND-IMAGE: none; BORDER-LEFT: #ff9600 1px solid; COLOR: #ff6500; BORDER-BOTTOM: #ff9600 1px solid; BACKGROUND-COLOR: #ffc794}");
            str.append(
                    "DIV.meneame SPAN.current {BORDER-RIGHT: #ff6500 1px solid; PADDING-RIGHT: 7px; BORDER-TOP: #ff6500 1px solid; PADDING-LEFT: 7px; FONT-WEIGHT: bold; PADDING-BOTTOM: 5px; BORDER-LEFT: #ff6500 1px solid; COLOR: #ff6500; MARGIN-RIGHT: 3px; PADDING-TOP: 5px; BORDER-BOTTOM: #ff6500 1px solid; BACKGROUND-COLOR: #ffbe94}");
            str.append(
                    "DIV.meneame SPAN.disabled {BORDER-RIGHT: #ffe3c6 1px solid; PADDING-RIGHT: 7px; BORDER-TOP: #ffe3c6 1px solid; PADDING-LEFT: 7px; PADDING-BOTTOM: 5px; BORDER-LEFT: #ffe3c6 1px solid; COLOR: #ffe3c6; MARGIN-RIGHT: 3px; PADDING-TOP: 5px; BORDER-BOTTOM: #ffe3c6 1px solid}");
            str.append("</style>");
            str.append("<div class=\"meneame\">");
            // 判定是否有上一页
            if (this.currentpage > 1) {
                str.append("<a href='" + url + "&currentpage=1' hidefocus=\"true\">首页</a>");
                str.append("&nbsp;&nbsp;&nbsp;");
                str.append("<a href='" + url + "&currentpage=" + ProPage + "' hidefocus=\"true\">上一页</a>");
                str.append("&nbsp;&nbsp;&nbsp;");
            } else {
                str.append("<span class=\"disabled\">首页</span>");
                str.append("&nbsp;&nbsp;");
                str.append("<span class=\"disabled\">上一页</span>");
                str.append("&nbsp;&nbsp;");
            }
            // 显示中间的图片
            if (this.pagecount <= 10) {
                for (int i = 1; i <= this.pagecount; i++) {
                    if (this.currentpage == i) {
                        str.append("<span class=\"current\">" + i + "</span>");
                    } else {
                        str.append("<a href='" + url + "&currentpage=" + i + "' hidefocus=\"true\">" + i
                                + "</a>&nbsp;&nbsp;");
                    }
                }
            } else {
                // 说明总数有超过10页
                // 制定特环的开始页和结束页
                int endPage = this.currentpage + 4;
                if (endPage > this.pagecount) {
                    endPage = this.pagecount;
                }
                int startPage = 0;
                if (this.pagecount >= 8 && this.currentpage >= 8) {
                    startPage = this.currentpage - 5;
                } else {
                    // 表示从第一页开始算
                    startPage = 1;
                }
                System.out.println(startPage);
                System.out.println(endPage);
                for (int i = startPage; i <= endPage; i++) {
                    if (this.currentpage == i) {
                        str.append("<span class=\"current\">" + i + "</span>");
                    } else {
                        str.append("<a href='" + url + "&currentpage=" + i + "' hidefocus=\"true\">" + i
                                + "</a>&nbsp;&nbsp;");
                    }
                }
            }

            // 判断下一页和尾页
            if (this.currentpage < this.pagecount) {
                if (this.currentpage < this.pagecount - 10) {
                    str.append("...");
                    str.append("<a href='" + url + "&currentpage=" + (this.pagecount - 1) + "' hidefocus=\"true\">"
                            + (this.pagecount - 1) + "</a>&nbsp;&nbsp;");
                    str.append("<a href='" + url + "&currentpage=" + this.pagecount + "' hidefocus=\"true\">"
                            + this.pagecount + "</a>&nbsp;&nbsp;");
                }

                str.append("<a href='" + url + "&currentpage=" + Nextpage + "' hidefocus=\"true\">下一页</a>");
                str.append("&nbsp;&nbsp;");
            } else {
                str.append("<span class=\"disabled\">下一页</span>");
                str.append("&nbsp;&nbsp;");
            }
            if (this.pagecount > 1 && this.currentpage != this.pagecount) {
                str.append("<a href='" + url + "&currentpage=" + pagecount + "' hidefocus=\"true\">尾页</a>");
                str.append("&nbsp;&nbsp;");
            } else {
                str.append("<span class=\"disabled\">尾页</span>");
                str.append("&nbsp;&nbsp;");
            }
            str.append("</div>");
        }

        return str.toString();
    }

    /**
     *
     * @return 返回带有所有请求参数的url
     */

    public String getParamUrl() {
        String url = "";
        url = this.request.getRequestURI().toString();
        if (url.indexOf("?") == -1) {
            url = url + "?";
        }
        String totalParams = "";
        Enumeration params = this.request.getParameterNames();// 得到所有参数名
        while (params.hasMoreElements()) {
            String tempName = params.nextElement().toString();
            String tempValue = this.request.getParameter(tempName);
            if (tempValue != null && !tempValue.equals("") && !tempName.equals("currentpage")) {
                if (totalParams.equals("")) {

                    totalParams = totalParams + tempName + "=" + tempValue;
                } else {
                    totalParams = totalParams + "&" + tempName + "=" + tempValue;
                }
            }
        }
        String totalUrl = url + totalParams;
        return totalUrl;
    }
}