package com.codenator.action;

import ch.ethz.ssh2.*;
import com.codenator.Container.WebsocketSessionContainer;
import com.codenator.file.SourceFile;
import com.codenator.language.Language;
import com.codenator.language.LanguageC;
import com.codenator.language.LanguageJava;
import com.codenator.language.LanguagePy;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;
import com.codenator.publicString.PublicString;

import java.io.*;
import java.util.Map;
import java.util.Scanner;

/**
 * Created by zhf on 2016/7/23.
 */

@SuppressWarnings("serial")
public class Run2 extends ActionSupport implements SessionAware {
	private String code;
	private Map<String, Object> session;
	private String language;
	private Connection conn;
	private String answer_input1;
	private String answer_output1;
	private String answer_input2;
	private String answer_output2;

	/* Create a shellSession, stored in the httpSession
    Refresh, close the tab when you need to conn, shellsession, pw are closed*/

	private void makeSession() {
		Session shellSession = (Session) session.get(PublicString.SHELLSESSION);
		conn = (Connection) session.get(PublicString.CONNECTION);
		PrintWriter pw = (PrintWriter) session.get(PublicString.PRINTWRITER);
		String sessionId = ServletActionContext.getRequest().getRequestedSessionId();
		if (shellSession == null) {
			try {
				System.out.println("shellsession is null");
				//SSH ������ ���� �õ�
				conn = new Connection(PublicString.SSH_SERVER_ADDRESS);
				conn.connect();
				//PublicString �� �ִ� ID �� PW �� �α��� �õ�, T/F ���θ� ��ȯ.
				boolean result = conn.authenticateWithPassword(PublicString.USERNAME, PublicString.PASSWORD);
				if(result == true)
					System.out.println(result + "�� SSH ���� ����!");
				else{
					System.out.println(result + "���� ����...");
				}
				shellSession = conn.openSession();
				pw = new PrintWriter(shellSession.getStdin());
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			try {
				pw.close();
				shellSession.close(); 
				// All processes executed under the shell are also terminated

				shellSession = conn.openSession();
				pw = new PrintWriter(shellSession.getStdin());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//session Map<>�� String(�̸�)�� ��(Object)�� �Է��Ѵ�. ����Ʈ�� ��������ٰ� ���� ��.
		session.put(PublicString.SHELLSESSION, shellSession);
		session.put(PublicString.PRINTWRITER, pw);
		session.put(PublicString.CONNECTION, conn);
	}

	@Override
	public String execute() { 
		try {
			//���� ����
			makeSession();
			final Session shellSession = (Session) session.get(PublicString.SHELLSESSION);
			final String sessionId = ServletActionContext.getRequest().getRequestedSessionId();

			/* Bring Question/Answer via Parameter Request */
			/* ide.jsp �� �ִ� ����� ������ �Ķ���� ��û�� ���� �����´� */
			final String answer_input1 = ServletActionContext.getRequest().getParameter("answer_input1");
			final String answer_output1 = ServletActionContext.getRequest().getParameter("answer_output1");
			final String answer_input2 = ServletActionContext.getRequest().getParameter("answer_input2");
			final String answer_output2 = ServletActionContext.getRequest().getParameter("answer_output2");

			System.out.println(language);  //ide.jsp ���� jQuery �� ���� ������ Language�� ���� ���
			if (language.equals("C/C++")) {
				try {
					SFTPv3Client sc = new SFTPv3Client(conn);
					sc.mkdir(PublicString.SOURCEFILEPUBLICPATH + sessionId, 755);
					SFTPv3FileHandle sf = sc.createFileTruncate(PublicString.SOURCEFILEPUBLICPATH + sessionId + "/" + "codenator.cpp");
					//!Important
					sc.write(sf, 0, code.getBytes(), 0, code.getBytes().length);
					sc.closeFile(sf);
					sc.close();
				} catch (SFTPException e) {
					System.out.println("an SFTPException in Run");
					SFTPv3Client sc = new SFTPv3Client(conn);
					SFTPv3FileHandle sf = sc.createFileTruncate(PublicString.SOURCEFILEPUBLICPATH + sessionId + "/" + "codenator.cpp");
					sc.write(sf, 0, code.getBytes(), 0, code.getBytes().length);
					sc.closeFile(sf);
					sc.close();
				}
				Language languageC = new LanguageC();
				//��� ����
				String command = languageC.getRunCommand(PublicString.SOURCEFILEPUBLICPATH + sessionId, "codenator", "cpp");
				command = command + answer_input1;
				System.out.println("Debug -> Detail of commandline = " + command);
				shellSession.execCommand(command); //Ŀ�ǵ� ����

				
				
				
			} 

			

		} catch (Exception e) {
			System.out.println("Run failed");
			e.printStackTrace();
		}

		return SUCCESS;
	}


	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public String getLanguage() {
		return language;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}


	public String getAnswer_input1() {
		return answer_input1;
	}


	public void setAnswer_input1(String answer_input1) {
		this.answer_input1 = answer_input1;
	}


	public String getAnswer_output1() {
		return answer_output1;
	}


	public void setAnswer_output1(String answer_output1) {
		this.answer_output1 = answer_output1;
	}


	public String getAnswer_input2() {
		return answer_input2;
	}


	public void setAnswer_input2(String answer_input2) {
		this.answer_input2 = answer_input2;
	}


	public String getAnswer_output2() {
		return answer_output2;
	}


	public void setAnswer_output2(String answer_output2) {
		this.answer_output2 = answer_output2;
	}


}
