// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAdminAPI {
  class CompleteDraftOrderMutation: GraphQLMutation {
    public static let operationName: String = "completeDraftOrder"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation completeDraftOrder($id: ID!, $paymentPending: Boolean) {
          draftOrderComplete(id: $id, paymentPending: $paymentPending) {
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
    public var paymentPending: GraphQLNullable<Bool>

    public init(
      id: ID,
      paymentPending: GraphQLNullable<Bool>
    ) {
      self.id = id
      self.paymentPending = paymentPending
    }

    public var __variables: Variables? { [
      "id": id,
      "paymentPending": paymentPending
    ] }

    public struct Data: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.Mutation }
      public static var __selections: [Apollo.Selection] { [
        .field("draftOrderComplete", DraftOrderComplete?.self, arguments: [
          "id": .variable("id"),
          "paymentPending": .variable("paymentPending")
        ]),
      ] }

      /// Completes a draft order and creates an order.
      public var draftOrderComplete: DraftOrderComplete? { __data["draftOrderComplete"] }

      /// DraftOrderComplete
      ///
      /// Parent Type: `DraftOrderCompletePayload`
      public struct DraftOrderComplete: ShopifyAdminAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.DraftOrderCompletePayload }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("draftOrder", DraftOrder?.self),
          .field("userErrors", [UserError].self),
        ] }

        /// The completed draft order.
        public var draftOrder: DraftOrder? { __data["draftOrder"] }
        /// The list of errors that occurred from executing the mutation.
        public var userErrors: [UserError] { __data["userErrors"] }

        /// DraftOrderComplete.DraftOrder
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

          /// DraftOrderComplete.DraftOrder.AppliedDiscount
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

            /// DraftOrderComplete.DraftOrder.AppliedDiscount.AmountV2
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

          /// DraftOrderComplete.DraftOrder.SubtotalPriceSet
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

            /// DraftOrderComplete.DraftOrder.SubtotalPriceSet.PresentmentMoney
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

          /// DraftOrderComplete.DraftOrder.TotalPriceSet
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

            /// DraftOrderComplete.DraftOrder.TotalPriceSet.PresentmentMoney
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

          /// DraftOrderComplete.DraftOrder.TotalTaxSet
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

            /// DraftOrderComplete.DraftOrder.TotalTaxSet.PresentmentMoney
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

        /// DraftOrderComplete.UserError
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