package com.codenator.language;

import com.codenator.file.SourceFile;

/**
 * Created by zhf on 2016/8/1.
 */
public interface Language {
	//���� �ִ� �͵��� �� ����� Language.java ���� �������̵� �ذ�.
    /*?��得�??�??���?
    * */
    public String getLanguage();

    /*?��?��源文件sourceFile?��得使?��运行?��?���?
    * */
    //����
    public String getRunCommand(String fileParentPath,String noExtensionName,String extensionName);



}
