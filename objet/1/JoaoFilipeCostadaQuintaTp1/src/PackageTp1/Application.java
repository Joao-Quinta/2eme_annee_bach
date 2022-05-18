package PackageTp1;

public class Application {

	public static void main(String[] args) {
		ComplexNumber z1 = new ComplexNumber(3,4);
		ComplexNumber z2 = new ComplexNumber(5,6);
		ComplexNumber z3 = z1.add(z2);
		//affiche le resultat sous forme polaire
		z3.print(false);
		z3.print(true);



	}

}
