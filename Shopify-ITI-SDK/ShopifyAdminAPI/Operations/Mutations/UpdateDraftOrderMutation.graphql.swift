// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAdminAPI {
  class UpdateDraftOrderMutation: GraphQLMutation {
    public static let operationName: String = "updateDraftOrder"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation updateDraftOrder($id: ID!, $input: DraftOrderInput!) {
          draftOrderUpdate(id: $id, input: $input) {
            __typename
            draftOrder {
              __typename
              id
              appliedDiscount {
                __typename
                amountV2 {
                  __typename
                  ...moneyInfo
                }
              }
              subtotalPriceSet {
                __typename
                presentmentMoney {
                  __typename
                  ...moneyInfo
                }
              }
              totalPriceSet {
                __typename
                presentmentMoney {
                  __typename
                  ...moneyInfo
                }
              }
              totalTaxSet {
                __typename
                presentmentMoney {
                  __typename
                  ...moneyInfo
                }
              }
            }
            userErrors {
              __typename
              field
              message
            }
          }
        }
        """#,
        fragments: [MoneyInfo.self]
      ))

    public var id: ID
    public var input: DraftOrderInput

    public init(
      id: ID,
      input: DraftOrderInput
    ) {
      self.id = id
      self.input = input
    }

    public var __variables: Variables? { [
      "id": id,
      "input": input
    ] }

    public struct Data: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.Mutation }
      public static var __selections: [Apollo.Selection] { [
        .field("draftOrderUpdate", DraftOrderUpdate?.self, arguments: [
          "id": .variable("id"),
          "input": .variable("input")
        ]),
      ] }

      /// Updates a draft order.
      ///
      /// If a checkout has been started for a draft order, any update to the draft will unlink the checkout. Checkouts
      /// are created but not immediately completed when opening the merchant credit card modal in the admin, and when a
      /// buyer opens the invoice URL. This is usually fine, but there is an edge case where a checkout is in progress
      /// and the draft is updated before the checkout completes. This will not interfere with the checkout and order
      /// creation, but if the link from draft to checkout is broken the draft will remain open even after the order is
      /// created.
      ///
      public var draftOrderUpdate: DraftOrderUpdate? { __data["draftOrderUpdate"] }

      /// DraftOrderUpdate
      ///
      /// Parent Type: `DraftOrderUpdatePayload`
      public struct DraftOrderUpdate: ShopifyAdminAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.DraftOrderUpdatePayload }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("draftOrder", DraftOrder?.self),
          .field("userErrors", [UserError].self),
        ] }

        /// The updated draft order.
        public var draftOrder: DraftOrder? { __data["draftOrder"] }
        /// The list of errors that occurred from executing the mutation.
        public var userErrors: [UserError] { __data["userErrors"] }

        /// DraftOrderUpdate.DraftOrder
        ///
        /// Parent Type: `DraftOrder`
        public struct DraftOrder: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.DraftOrder }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("id", ShopifyAdminAPI.ID.self),
            .field("appliedDiscount", AppliedDiscount?.self),
            .field("subtotalPriceSet", SubtotalPriceSet.self),
            .field("totalPriceSet", TotalPriceSet.self),
            .field("totalTaxSet", TotalTaxSet.self),
          ] }

          /// A globally-unique ID.
          public var id: ShopifyAdminAPI.ID { __data["id"] }
          /// The order-level discount applied to the draft order.
          public var appliedDiscount: AppliedDiscount? { __data["appliedDiscount"] }
          /// A subtotal of the line items and corresponding discounts. The subtotal doesn't include shipping charges, shipping discounts, or taxes.
          public var subtotalPriceSet: SubtotalPriceSet { __data["subtotalPriceSet"] }
          /// The total amount of the draft order including taxes, shipping charges, and discounts.
          public var totalPriceSet: TotalPriceSet { __data["totalPriceSet"] }
          /// The total amount of taxes for the draft order.
          public var totalTaxSet: TotalTaxSet { __data["totalTaxSet"] }

          /// DraftOrderUpdate.DraftOrder.AppliedDiscount
          ///
          /// Parent Type: `DraftOrderAppliedDiscount`
          public struct AppliedDiscount: ShopifyAdminAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.DraftOrderAppliedDiscount }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("amountV2", AmountV2.self),
            ] }

            /// Amount of money discounted.
            public var amountV2: AmountV2 { __data["amountV2"] }

            /// DraftOrderUpdate.DraftOrder.AppliedDiscount.AmountV2
            ///
            /// Parent Type: `MoneyV2`
            public struct AmountV2: ShopifyAdminAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyV2 }
              public static var __selections: [Apollo.Selection] { [
                .field("__typename", String.self),
                .fragment(MoneyInfo.self),
              ] }

              /// Decimal money amount.
              public var amount100: ShopifyAdminAPI.Decimal { __data["amount100"] }
              /// Currency of the money.
              public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }

              public struct Fragments: FragmentContainer {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public var moneyInfo: MoneyInfo { _toFragment() }
              }
            }
          }

          /// DraftOrderUpdate.DraftOrder.SubtotalPriceSet
          ///
          /// Parent Type: `MoneyBag`
          public struct SubtotalPriceSet: ShopifyAdminAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyBag }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("presentmentMoney", PresentmentMoney.self),
            ] }

            /// Amount in presentment currency.
            public var presentmentMoney: PresentmentMoney { __data["presentmentMoney"] }

            /// DraftOrderUpdate.DraftOrder.SubtotalPriceSet.PresentmentMoney
            ///
            /// Parent Type: `MoneyV2`
            public struct PresentmentMoney: ShopifyAdminAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyV2 }
              public static var __selections: [Apollo.Selection] { [
                .field("__typename", String.self),
                .fragment(MoneyInfo.self),
              ] }

              /// Decimal money amount.
              public var amount100: ShopifyAdminAPI.Decimal { __data["amount100"] }
              /// Currency of the money.
              public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }

              public struct Fragments: FragmentContainer {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public var moneyInfo: MoneyInfo { _toFragment() }
              }
            }
          }

          /// DraftOrderUpdate.DraftOrder.TotalPriceSet
          ///
          /// Parent Type: `MoneyBag`
          public struct TotalPriceSet: ShopifyAdminAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyBag }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("presentmentMoney", PresentmentMoney.self),
            ] }

            /// Amount in presentment currency.
            public var presentmentMoney: PresentmentMoney { __data["presentmentMoney"] }

            /// DraftOrderUpdate.DraftOrder.TotalPriceSet.PresentmentMoney
            ///
            /// Parent Type: `MoneyV2`
            public struct PresentmentMoney: ShopifyAdminAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyV2 }
              public static var __selections: [Apollo.Selection] { [
                .field("__typename", String.self),
                .fragment(MoneyInfo.self),
              ] }

              /// Decimal money amount.
              public var amount100: ShopifyAdminAPI.Decimal { __data["amount100"] }
              /// Currency of the money.
              public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }

              public struct Fragments: FragmentContainer {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public var moneyInfo: MoneyInfo { _toFragment() }
              }
            }
          }

          /// DraftOrderUpdate.DraftOrder.TotalTaxSet
          ///
          /// Parent Type: `MoneyBag`
          public struct TotalTaxSet: ShopifyAdminAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyBag }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("presentmentMoney", PresentmentMoney.self),
            ] }

            /// Amount in presentment currency.
            public var presentmentMoney: PresentmentMoney { __data["presentmentMoney"] }

            /// DraftOrderUpdate.DraftOrder.TotalTaxSet.PresentmentMoney
            ///
            /// Parent Type: `MoneyV2`
            public struct PresentmentMoney: ShopifyAdminAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyV2 }
              public static var __selections: [Apollo.Selection] { [
                .field("__typename", String.self),
                .fragment(MoneyInfo.self),
              ] }

              /// Decimal money amount.
              public var amount100: ShopifyAdminAPI.Decimal { __data["amount100"] }
              /// Currency of the money.
              public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }

              public struct Fragments: FragmentContainer {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public var moneyInfo: MoneyInfo { _toFragment() }
              }
            }
          }
        }

        /// DraftOrderUpdate.UserError
        ///
        /// Parent Type: `UserError`
        public struct UserError: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.UserError }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("field", [String]?.self),
            .field("message", String.self),
          ] }

          /// The path to the input field that caused the error.
          public var field: [String]? { __data["field"] }
          /// The error message.
          public var message: String { __data["message"] }
        }
      }
    }
  }

}