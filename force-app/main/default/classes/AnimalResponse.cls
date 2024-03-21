public class AnimalResponse {

	public Animal animal;
	public List<String> animals;
	public class Animal {
		public Integer id;
		public String name;
		public String eats;
		public String says;
	}

	
	public static AnimalResponse parse(String json) {
		return (AnimalResponse) System.JSON.deserializeStrict(json, AnimalResponse.class);
	}
}