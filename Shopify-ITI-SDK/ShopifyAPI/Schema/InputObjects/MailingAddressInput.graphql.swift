// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAPI {
  /// The input fields to create or update a mailing address.
  struct MailingAddressInput: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      address1: GraphQLNullable<String> = nil,
      address2: GraphQLNullable<String> = nil,
      city: GraphQLNullable<String> = nil,
      company: GraphQLNullable<String> = nil,
      country: GraphQLNullable<String> = nil,
      firstName: GraphQLNullable<String> = nil,
      lastName: GraphQLNullable<String> = nil,
      phone: GraphQLNullable<String> = nil,
      province: GraphQLNullable<String> = nil,
      zip: GraphQLNullable<String> = nil
    ) {
      __data = InputDict([
        "address1": address1,
        "address2": address2,
        "city": city,
        "company": company,
        "country": country,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "province": province,
        "zip": zip
      ])
    }

    /// The first line of the address. Typically the street address or PO Box number.
    ///
    public var address1: GraphQLNullable<String> {
      get { __data["address1"] }
      set { __data["address1"] = newValue }
    }

    /// The second line of the address. Typically the number of the apartment, suite, or unit.
    ///
    public var address2: GraphQLNullable<String> {
      get { __data["address2"] }
      set { __data["address2"] = newValue }
    }

    /// The name of the city, district, village, or town.
    ///
    public var city: GraphQLNullable<String> {
      get { __data["city"] }
      set { __data["city"] = newValue }
    }

    /// The name of the customer's company or organization.
    ///
    public var company: GraphQLNullable<String> {
      get { __data["company"] }
      set { __data["company"] = newValue }
    }

    /// The name of the country.
    public var country: GraphQLNullable<String> {
      get { __data["country"] }
      set { __data["country"] = newValue }
    }

    /// The first name of the customer.
    public var firstName: GraphQLNullable<String> {
      get { __data["firstName"] }
      set { __data["firstName"] = newValue }
    }

    /// The last name of the customer.
    public var lastName: GraphQLNullable<String> {
      get { __data["lastName"] }
      set { __data["lastName"] = newValue }
    }

    /// A unique phone number for the customer.
    ///
    /// Formatted using E.164 standard. For example, _+16135551111_.
    ///
    public var phone: GraphQLNullable<String> {
      get { __data["phone"] }
      set { __data["phone"] = newValue }
    }

    /// The region of the address, such as the province, state, or district.
    public var province: GraphQLNullable<String> {
      get { __data["province"] }
      set { __data["province"] = newValue }
    }

    /// The zip or postal code of the address.
    public var zip: GraphQLNullable<String> {
      get { __data["zip"] }
      set { __data["zip"] = newValue }
    }
  }

}