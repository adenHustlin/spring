/**
 * 
 */
package interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerExceptionResolverComposite;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.mysql.cj.Session;

/**
 * @author baekd
 * @packageName: interceptor
 * @fileName: AuthenticationInterceptor.java
 * @date: 2021. 9. 9.
 * description:
 */
public class AuthenticationInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("authentication interceptor");
		// session 객체를 가져옴
        HttpSession session = request.getSession();
        // login처리를 담당하는 사용자 정보를 담고 있는 객체를 가져옴
         
        if ( session.getAttribute("loginMember")==null ){
            // 로그인이 안되어 있는 상태임으로 로그인 폼으로 다시 돌려보냄(redirect)
        	System.out.println("로그인안되어있어서 로그인폼으로이동");
        	savePrevDest(request);
            response.sendRedirect("/member/login");
            return false; // 더이상 컨트롤러 요청으로 가지 않도록false로 반환함
        }
         
        // preHandle의return은 컨트롤러 요청 uri로 가도 되냐 안되냐를 허가하는 의미임
        // 따라서true로하면 컨트롤러 uri로 가게 됨.
        return true;
	}
//	게시판이나 상세게시판에서 바로 로그인 페이지를 띄웠을때 전에ㅇ있었던곳으로 바로돌아갈수있게 설정해주기
	private void savePrevDest(HttpServletRequest request) {
		String uri= request.getRequestURI();
		String query=request.getQueryString();
		String qweStrin=request.getHeader("Referer");
		System.out.println(qweStrin);
		if(query==null||query.equals("null")) {
			query="";
			
		}else {
			query="?"+query;
		}
		if(request.getMethod().equals("GET")) {
			
			request.getSession().setAttribute("destination",uri+query);
			
			
		}
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	
		super.postHandle(request, response, handler, modelAndView);
	}

}
