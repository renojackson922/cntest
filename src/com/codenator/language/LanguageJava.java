package com.codenator.language;

import com.codenator.file.SourceFile;
import com.codenator.publicString.PublicString;

/**
 * Created by zhf on 2016/8/1.
 */
public class LanguageJava implements Language {

    private String languageName="java";
    private String runCommand;


    /*?��得�??�??���?
    * */
    @Override
    public String getLanguage(){
        return languageName;
    }

    /*?��?��源文件sourceFile?��得使?��运行?��?���?
    * */
    @Override
    public String getRunCommand(String fileParentPath,String noExtensionName,String extensionName){
        runCommand="chmod 755 "+fileParentPath+";"+"cd "+fileParentPath+";"+"chmod 755 "+noExtensionName+"."+extensionName+";";
        runCommand+="javac "+noExtensionName+"."+extensionName+";";

        runCommand+="java "+noExtensionName+";";
        return runCommand;
    }


}
