package com.codenator.language;

import com.codenator.file.SourceFile;

/**
 * Created by zhf on 2016/8/1.
 */
public interface Language {
	//여기 있는 것들을 각 언어의 Language.java 에서 오버라이드 해감.
    /*?렩孃쀨??鼇??릫燁?
    * */
    public String getLanguage();

    /*?졊?뜮繹먩뻼餓턵ourceFile?렩孃쀤슴?끀瓦먫죱?쉪?뫝餓?
    * */
    //여기
    public String getRunCommand(String fileParentPath,String noExtensionName,String extensionName);



}
