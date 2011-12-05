void executeCmd() {
  
  //text("Currently recording...", 5, 15);

  newFile();

  File wd = new File("/workspaces/voiceboxProcessing/voicebox/processing/voicebox/data/sox");
  System.out.println(wd);
  Process proc = null;
  try {
    proc = Runtime.getRuntime().exec("/bin/bash", null, wd);
  }
  catch (IOException e) {
    e.printStackTrace();
  }
  if (proc != null) {
    BufferedReader in = new BufferedReader(new InputStreamReader(proc.getInputStream()));
    PrintWriter out = new PrintWriter(new BufferedWriter(new OutputStreamWriter(proc.getOutputStream())), true);
    out.println("cd ..");
    println("changed directory to");
    out.println("pwd");
    //println("now recording");
    out.println("sox/rec Rec/" + boxName + currentDate +".ogg trim 0 5");
    
    out.println("exit");
    try {
      String line;
      while ( (line = in.readLine ()) != null) {
        System.out.println(line);
        //inputReceived = false;
      }
      proc.waitFor();
      in.close();
      out.close();
      proc.destroy();
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }
}
