//
//  FAQView.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 18/06/2023.
//

import SwiftUI


struct FAQView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Frequently Asked Questions (FAQ)")
                    .font(.title)
                    .bold()
                
                FAQItem(question: "How can I place an order?", answer: "To place an order, simply browse through our products, select the items you want to purchase, and click on the 'Add to Cart' button. Once you have added all the desired items to your cart, proceed to the checkout page, enter your shipping and payment details, and confirm your order.")
                
                FAQItem(question: "What payment methods do you accept?", answer: "We accept various payment methods, including credit/debit cards (Visa, Mastercard, American Express), PayPal, and mobile payment options such as Apple Pay and Google Pay. At checkout, you can choose the payment method that suits you best.")
                
                FAQItem(question: "How long does shipping take?", answer: "The shipping time can vary depending on your location and the shipping method selected. We strive to process and ship orders as quickly as possible. Once your order is shipped, you will receive a confirmation email with tracking information to monitor its progress. For more specific delivery timeframes, please refer to our shipping policy.")
                
                FAQItem(question: "Do you offer international shipping?", answer: "Yes, we offer international shipping to many countries. However, please note that shipping availability and charges may vary depending on the destination. During the checkout process, you can enter your address to check if we deliver to your country.")
                
                FAQItem(question: "What is your return policy?", answer: "We have a hassle-free return policy. If you are not satisfied with your purchase or have received a defective item, you can initiate a return within 30 days of receiving the product. Please ensure the item is unused and in its original packaging. For more detailed instructions on how to return a product, please refer to our returns policy.")
                
                FAQItem(question: "How can I track my order?", answer: "Once your order has been shipped, you will receive a confirmation email with a tracking number and a link to track your package. You can click on the link or visit the 'Track Order' section on our website and enter your tracking number to get the latest updates on the whereabouts of your shipment.")
                
                FAQItem(question: "What if I have further questions or need support?", answer: "If you have any additional questions, concerns, or need assistance, our customer support team is here to help. You can reach out to us through the 'Contact Us' page on our website, and our dedicated support staff will respond to your inquiries as soon as possible.")
            }
            .padding()
        }
    }
}

struct FAQItem: View {
    var question: String
    var answer: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(question)
                .font(.headline)
                .bold()
            
            Text(answer)
                .font(.body)
        }
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView()
    }
}
