import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    
    var body: some View {
        HStack{
                TextField("Search...", text: $text)
                    .padding(8)
                    .padding(.horizontal, 24)
                    .background(Color.secondayBackground)
                    .cornerRadius(8)
                    .foregroundColor(.blackWhite)
                    .overlay(
                        HStack{
                            Image(systemName: "magnifyingglass")
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                                .foregroundColor(.background)
                        }
                    )
            }
        }
    }

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
