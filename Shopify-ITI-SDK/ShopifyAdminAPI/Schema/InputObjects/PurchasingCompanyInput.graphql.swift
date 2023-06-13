// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI {
  /// The input fields for a purchasing company, which is a combination of company, company contact, and company location.
  ///
  struct PurchasingCompanyInput: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      companyId: ID,
      companyContactId: ID,
      companyLocationId: ID
    ) {
      __data = InputDict([
        "companyId": companyId,
        "companyContactId": companyContactId,
        "companyLocationId": companyLocationId
      ])
    }

    /// ID of the company.
    public var companyId: ID {
      get { __data["companyId"] }
      set { __data["companyId"] = newValue }
    }

    /// ID of the company contact.
    public var companyContactId: ID {
      get { __data["companyContactId"] }
      set { __data["companyContactId"] = newValue }
    }

    /// ID of the company location.
    public var companyLocationId: ID {
      get { __data["companyLocationId"] }
      set { __data["companyLocationId"] = newValue }
    }
  }

}