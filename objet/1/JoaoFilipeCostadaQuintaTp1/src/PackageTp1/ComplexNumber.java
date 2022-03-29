package PackageTp1;
import java.lang.Math;

public class ComplexNumber {
	
	private double a;
	private double b;
	private double r;
	private double t;
	
	
	public ComplexNumber () {
		this.a = 0;
		this.b = 0;		
	}
	
	public ComplexNumber (double reel, double imaginaire) {
		this.a = reel;
		this.b = imaginaire;		
	}
	
	private void algebraic2polar() {
		r = Math.sqrt(Math.pow(a,2)+Math.pow(b,2));
		t = Math.atan(b/a);
	}

	//FONCTIONS 
    //////// addition
	public ComplexNumber add(ComplexNumber op) {
		double newA;
		double newB;
		newA = this.a + op.getA();	
		newB = this.b + op.getB();
		return new ComplexNumber(newA, newB);
	}
    //////// soustraction
	public ComplexNumber soustraction(ComplexNumber op) {
		double newA;
		double newB;
		newA = this.a - op.getA();	
		newB = this.b - op.getB();
		return new ComplexNumber(newA, newB);
	}	
    //////// multiplication
	public ComplexNumber multiplication(ComplexNumber op) {
		double newA;
		double newB;
		newA = (this.a * op.getA()) - (this.b * op.getB());
		newB = (this.a * op.getB()) + (op.getA() * this.b);
		return new ComplexNumber(newA, newB);
	}
	//////// division
	public ComplexNumber division(ComplexNumber op) {
		double newA;
		double newB;
		newA = ((this.a * op.getA()) + (this.b * op.getB()))/(Math.pow(op.getA(), 2)+Math.pow(op.getB(), 2));	
		newB = ((this.b * op.getB()) - (this.a * op.getB()))/(Math.pow(op.getA(), 2)+Math.pow(op.getB(), 2));
		return new ComplexNumber(newA, newB);
	}
	///////// print
	public void print(boolean polar) {
		if (polar == true) {
			this.algebraic2polar();
			System.out.println(this.r + " * exp(i*" + this.t + ")");
		} else {
			System.out.println(this.a + " +  i*" + this.b);
		}
	}
	
	
	//GETTERS
	public double getA() {
		return a;		
	}
	public double getB() {
		return b;
	}
	public double getPhase() {
		algebraic2polar();
		return r;
	}
	public double getModule() {
		algebraic2polar();
		return t;
	}
	
}



