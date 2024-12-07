import SwiftUI

struct InputRestaurantsView: View {
    @State private var restaurants: [String] = []
    @State private var newRestaurant = ""
    @State private var selectedRestaurant = ""
    @State private var showAlert = false

    var body: some View {
        VStack {
            Text("Input Restaurants")
                .font(.title)
                .padding()

            List {
                ForEach(restaurants, id: \.self) { restaurant in
                    Text(restaurant)
                }
                .onDelete(perform: deleteRestaurant)
            }

            HStack {
                TextField("Enter a restaurant", text: $newRestaurant)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: addRestaurant) {
                    Text("Add")
                }
            }
            .padding()

            Button(action: {
                if !restaurants.isEmpty {
                    selectedRestaurant = restaurants.randomElement()!
                    showAlert = true
                }
            }) {
                Text("Choose a Restaurant")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationBarTitle("Input Restaurants", displayMode: .inline)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Congratulations!"), message: Text("You will be eating at \(selectedRestaurant)"), dismissButton: .default(Text("OK")))
        }
    }

    func addRestaurant() {
        if !newRestaurant.isEmpty {
            restaurants.append(newRestaurant)
            newRestaurant = ""
        }
    }

    func deleteRestaurant(at offsets: IndexSet) {
        restaurants.remove(atOffsets: offsets)
    }
}

#Preview {
    InputRestaurantsView()
}
