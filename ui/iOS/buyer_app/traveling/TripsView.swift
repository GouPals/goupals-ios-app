import SwiftUI

struct TripsView: View {
    struct Trip: Identifiable {
        let id = UUID()
        var departureCity: String
        var departureDate: String
        var departureTime: String
        var arrivalCity: String
        var arrivalDate: String
        var arrivalTime: String
        var flightNumber: String
    }
    
    @State private var trips = [
        Trip(departureCity: "City A", departureDate: "2024-08-20", departureTime: "10:00 AM", arrivalCity: "City B", arrivalDate: "2024-08-20", arrivalTime: "1:00 PM", flightNumber: "ABC123"),
        Trip(departureCity: "City C", departureDate: "2024-08-21", departureTime: "2:00 PM", arrivalCity: "City D", arrivalDate: "2024-08-21", arrivalTime: "5:00 PM", flightNumber: "XYZ789")
    ]
    
    @State private var showingEditOptions = false
    @State private var showingAddTripSheet = false
    @State private var selectedTrips = Set<UUID>()
    @State private var isEditing = false
    @State private var showingDetailView = false
    @State private var selectedTrip: Trip? = nil
    
    var body: some View {
        NavigationView {
            List(trips) { trip in
                HStack(alignment: .center, spacing: 10) {
                    // Departure details
                    VStack(alignment: .leading) {
                        Text(trip.departureCity)
                            .font(.headline)
                        Text("\(trip.departureDate), \(trip.departureTime)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    // Custom long arrow
                    VStack(alignment: .center) {
                        Text("✈️")
                        LongArrowRight()
                            .stroke(Color.black, lineWidth: 2)
                            .frame(height: 20) // Adjust height as needed
                        Text(trip.flightNumber)
                            .font(.headline)
                            .bold()
                    }
                    
                    
                    Spacer()
                    
                    // Arrival details
                    VStack(alignment: .trailing) {
                        Text(trip.arrivalCity)
                            .font(.headline)
                        Text("\(trip.arrivalDate), \(trip.arrivalTime)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(10)
                .background(Color(.systemBackground))
                .cornerRadius(8)
                .shadow(radius: 1)
                .padding(.vertical, 5) // Padding between each item
                .onTapGesture {
                    selectedTrip = trip
                    showingDetailView.toggle()
                }
            }
            .navigationTitle("Trips")
            .toolbar {
                // Edit button on the top left
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Edit") {
                        showingEditOptions.toggle()
                    }
                    .actionSheet(isPresented: $showingEditOptions) {
                        ActionSheet(
                            title: Text("Edit Options"),
                            buttons: [
                                .default(Text("Select")) {
                                    isEditing.toggle()
                                },
                                .default(Text("Edit Pin")),
                                .default(Text("Recently Deleted")),
                                .cancel()
                            ]
                        )
                    }
                }
                
                // Write button on the top right
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddTripSheet.toggle()
                    }) {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
            .sheet(isPresented: $showingAddTripSheet) {
                AddTripView { newTrip in
                    trips.append(newTrip)
                }
            }
            .sheet(isPresented: $showingDetailView) {
                if let selectedTrip = selectedTrip {
                    TripDetailView(trip: selectedTrip) { updatedTrip in
                        if let index = trips.firstIndex(where: { $0.id == selectedTrip.id }) {
                            trips[index] = updatedTrip
                        }
                    }
                }
            }
        }
    }
}

struct LongArrowRight: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Draw the main line of the arrow
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - 10, y: rect.midY))

        // Draw the arrowhead
        path.move(to: CGPoint(x: rect.maxX - 10, y: rect.midY - 5))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - 10, y: rect.midY + 5))

        return path
    }
}


struct AddTripView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var departureCity = ""
    @State private var arrivalCity = ""
    @State private var departureDate = Date()
    @State private var departureTime = ""
    @State private var arrivalDate = Date()
    @State private var arrivalTime = ""
    @State private var flightNumber = ""
    
    var onSave: (TripsView.Trip) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Trip Information")) {
                    TextField("Departure City", text: $departureCity)
                    
                    // DatePicker for Departure Date
                    DatePicker("Departure Date", selection: $departureDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                    
                    TextField("Departure Time", text: $departureTime)
                    
                    TextField("Arrival City", text: $arrivalCity)
                    
                    // DatePicker for Arrival Date
                    DatePicker("Arrival Date", selection: $arrivalDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                    
                    TextField("Arrival Time", text: $arrivalTime)
                    TextField("Flight Number", text: $flightNumber)
                }
            }
            .navigationTitle("New Trip")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateStyle = .medium
                        dateFormatter.timeStyle = .none
                        
                        let newTrip = TripsView.Trip(
                            departureCity: departureCity,
                            departureDate: dateFormatter.string(from: departureDate),
                            departureTime: departureTime,
                            arrivalCity: arrivalCity,
                            arrivalDate: dateFormatter.string(from: arrivalDate),
                            arrivalTime: arrivalTime,
                            flightNumber: flightNumber
                        )
                        onSave(newTrip)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}


struct TripDetailView: View {
    @State var trip: TripsView.Trip
    var onSave: (TripsView.Trip) -> Void
    
    var body: some View {
        VStack {
            TextField("Flight Number", text: $trip.flightNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Departure City", text: $trip.departureCity)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Departure Date", text: $trip.departureDate)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Departure Time", text: $trip.departureTime)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()


            TextField("Arrival City", text: $trip.arrivalCity)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Arrival Date", text: $trip.arrivalDate)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Arrival Time", text: $trip.arrivalTime)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save") {
                onSave(trip)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}



//struct TripsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TripsView()
//    }
//}
