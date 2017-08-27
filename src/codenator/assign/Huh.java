package codenator.assign;

import java.util.Random;

public class Huh {

	public static void main(String[] args) {
		int a = 150;
		int b = 21;
		for(int i = 150; i < 200; i++) {
			Random r = new Random();
			int c = (r.nextInt(5)+1);
			if(b>=0) {
				b = b- c;
			}else {
				
			}
				
			System.out.print("[" + a + "," + c + "], ");
			a++;
			
		}

	}

}
