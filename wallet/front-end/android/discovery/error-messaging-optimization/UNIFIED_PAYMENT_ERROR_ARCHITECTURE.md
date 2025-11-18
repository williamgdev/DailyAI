# UNIFIED PAYMENT ERROR ARCHITECTURE PROPOSAL

**Date:** November 12, 2025  
**Project:** Cross-Platform Error Message Standardization Initiative  
**Status:** ARCHITECTURE PROPOSAL  

## 🚨 PROBLEM WITH CURRENT APPROACH

### Current Separate Enum Strategy:
```
❌ CreditCardErrors enum
❌ GiftCardErrors enum  
❌ EBTCardErrors enum
❌ WICCardErrors enum
❌ DSBenefitCardErrors enum
❌ PayPalErrors enum
```

### Issues with Separate Enums:
1. **Code Duplication**: Each enum repeats similar structure and methods
2. **Inconsistent Interfaces**: Different method signatures across enums
3. **Maintenance Overhead**: Changes replicated across 6+ enums × 3 platforms = 18+ files
4. **Type Safety Problems**: Can't treat payment errors uniformly
5. **Scaling Issues**: Adding new payment types requires new enum creation
6. **Testing Complexity**: Need separate test suites for each enum

---

## ✅ UNIFIED PAYMENT ERROR ARCHITECTURE

### 🏗️ **ARCHITECTURE OVERVIEW**

Instead of separate enums, create a **unified PaymentError system** with:

1. **Single PaymentError enum** with all 67 error codes
2. **Payment Type categorization** within the enum
3. **Unified interface** across all platforms
4. **Shared error handling logic**
5. **Consistent API** for all payment types

---

## 💡 **PROPOSED UNIFIED ARCHITECTURE**

### **iOS Implementation**

```swift
// PaymentErrors.swift - UNIFIED ERROR ENUM
enum PaymentErrors: String, CaseIterable {
    // Credit Card Errors
    case avsRejected = "ERROR_AVS_REJECTED"
    case cardExpired = "ERROR_CARD_EXPIRED"
    case credentialDeclined = "ERROR_CREDENTIAL_DECLINED"
    case cardLimitReached = "ERROR_CARD_LIMIT_REACHED"
    case policyRejected = "ERROR_CC_POLICY_REJECTED"
    case instrumentBlocked = "ERROR_INSTRUMENT_BLOCKED"
    case invalidName = "ERROR_INVALID_NAME"
    case dsCardLimitReached = "ERROR_DS_CARD_LIMIT_REACHED"
    
    // Gift Card Errors
    case duplicateGiftCard = "ERROR_DUPLICATE_GIFTCARD"
    case giftCardBalanceZero = "ERROR_GIFTCARD_BALANCE_ZERO"
    case notGiftCard = "ERROR_NOT_GIFT_CARD"
    case provisionLinkExpired = "ERROR_PROVISION_LINK_EXPIRED"
    case gcDecryptError = "ERROR_GC_DECRYPT_ERROR"
    case duplicateDSCard = "ERROR_DUPLICATE_DS_CARD"
    case dsInStoreCardOnly = "ERROR_DS_IN_STORE_CARD_ONLY"
    
    // EBT Card Errors
    case ebtCardInTooManyAccounts = "ERROR_EBT_CARD_IS_IN_TOO_MANY_OTHER_ACCOUNTS"
    case ebtPolicyRejected = "ERROR_EBT_POLICY_REJECTED"
    case notEBTCard = "ERROR_NOT_EBT_CARD"
    case ebtCardNDaysLimit = "ERROR_EBT_CARD_N_DAYS_LIMIT"
    case ebtCardNHoursLimit = "ERROR_EBT_CARD_N_HOURS_LIMIT"
    
    // WIC Card Errors
    case notWICCard = "ERROR_NOT_WIC_CARD"
    case incorrectCard = "INCORRECT_CARD"
    case wicPolicyRejected = "ERROR_WIC_POLICY_REJECTED"
    case cardInTooManyAccounts = "CARD_IS_IN_TOO_MANY_OTHER_ACCOUNTS"
    case noBalance = "NO_BALANCE"
    case getBalanceFailed = "GET_BALANCE_FAILED"
    case incorrectPin = "INCORRECT_PIN"
    case pinBlock = "PIN_BLOCK"
    case pinRetryExceeded = "PIN_RETRY_EXCEEDED"
    case invalidPaymentProcessor = "INVALID_PAYMENT_PROCESSOR"
    
    // DS/Benefit Card Errors
    case duplicateDSCardBenefit = "ERROR_DUPLICATE_DS_CARD"
    case dsInvalidType = "ERROR_DS_INVALID_TYPE"
    case dsCardNotActivated = "ERROR_DS_CARD_NOT_ACTIVATED"
    case dsProgramExpired = "ERROR_DS_PROGRAM_EXPIRED"
    case expiredCardInactiveProgramExpired = "ERROR_EXPIRED_CARD_INACTIVE_CARD_PROGRAM_EXPIRED"
    case dsBenefitCardNumberPinMismatch = "ERROR_DS_BENEFIT_CARD_NUMBER_PIN_MISMATCH"
    case dsBenefitCardIneligible = "ERROR_DS_BENEFIT_CARD_INELIGIBLE"
    case dsBenefitInfoError = "ERROR_DS_BENEFIT_INFO_ERROR"
    case dsBenefitCardDobError = "ERROR_DS_BENEFIT_CARD_DOB_ERROR"
    case dsBenefitCardPostalCodeError = "ERROR_DS_BENEFIT_CARD_POSTALCODE_ERROR"
    case dsBenefitCardInAnotherAccount = "ERROR_DS_BENEFIT_CARD_IN_ANOTHER_ACCOUNT"
    case dsCardLost = "ERROR_DS_CARD_LOST"
    case dsCardStolen = "ERROR_DS_CARD_STOLEN"
    case dsCardFrozen = "ERROR_DS_CARD_FROZEN"
    
    // PayPal Errors (Future: specific codes when available)
    // case paypalGeneralError = "ERROR_PAYPAL_GENERAL"
    
    // UNIFIED PAYMENT TYPE CATEGORIZATION
    var paymentType: PaymentType {
        switch self {
        case .avsRejected, .cardExpired, .credentialDeclined, .cardLimitReached, 
             .policyRejected, .instrumentBlocked, .invalidName, .dsCardLimitReached:
            return .creditCard
            
        case .duplicateGiftCard, .giftCardBalanceZero, .notGiftCard, 
             .provisionLinkExpired, .gcDecryptError, .duplicateDSCard, .dsInStoreCardOnly:
            return .giftCard
            
        case .ebtCardInTooManyAccounts, .ebtPolicyRejected, .notEBTCard, 
             .ebtCardNDaysLimit, .ebtCardNHoursLimit:
            return .ebtCard
            
        case .notWICCard, .incorrectCard, .wicPolicyRejected, .cardInTooManyAccounts,
             .noBalance, .getBalanceFailed, .incorrectPin, .pinBlock, 
             .pinRetryExceeded, .invalidPaymentProcessor:
            return .wicCard
            
        case .duplicateDSCardBenefit, .dsInvalidType, .dsCardNotActivated, 
             .dsProgramExpired, .expiredCardInactiveProgramExpired, 
             .dsBenefitCardNumberPinMismatch, .dsBenefitCardIneligible,
             .dsBenefitInfoError, .dsBenefitCardDobError, 
             .dsBenefitCardPostalCodeError, .dsBenefitCardInAnotherAccount,
             .dsCardLost, .dsCardStolen, .dsCardFrozen:
            return .dsBenefitCard
        }
    }
    
    // UNIFIED LOCALIZED MESSAGE MAPPING
    var localizedMessage: String {
        switch self {
        // Credit Card Messages
        case .avsRejected, .cardExpired, .credentialDeclined:
            return NSLocalizedString("Unable to save card. Please check the card number, CVV and expiration date and try again, or use a different payment method.", comment: "Credit card validation error")
        case .cardLimitReached:
            return NSLocalizedString("20 cards max for this payment type. To add a new card, delete one.", comment: "Credit card limit error")
        case .policyRejected:
            return NSLocalizedString("Unable to add card. Try again later.", comment: "Policy rejected error")
        case .instrumentBlocked:
            return NSLocalizedString("This payment method is currently unavailable. Please use a different payment method.", comment: "Instrument blocked error")
        case .invalidName:
            return NSLocalizedString("Please check the name on the card and try again.", comment: "Invalid name error")
        case .dsCardLimitReached:
            return NSLocalizedString("You've reached the limit for HSA/FSA cards. To add a new card, delete one.", comment: "DS card limit error")
        
        // Gift Card Messages  
        case .duplicateGiftCard:
            return NSLocalizedString("Done! You've already saved this card.", comment: "Duplicate gift card success - iOS behavior")
        case .giftCardBalanceZero:
            return NSLocalizedString("This gift card has no remaining balance.", comment: "Zero balance error")
        case .notGiftCard:
            return NSLocalizedString("This doesn't appear to be a valid gift card.", comment: "Invalid gift card error")
        case .provisionLinkExpired:
            return NSLocalizedString("This link has expired. Please try again.", comment: "Provision link expired")
        case .gcDecryptError:
            return NSLocalizedString("Unable to process this gift card. Try again later.", comment: "Gift card decrypt error")
        case .duplicateDSCard:
            return NSLocalizedString("This card is already saved to your account.", comment: "Duplicate DS card error")
        case .dsInStoreCardOnly:
            return NSLocalizedString("This card can only be used in-store.", comment: "DS in-store only error")
            
        // EBT Messages
        case .ebtCardInTooManyAccounts:
            return NSLocalizedString("This card is linked to too many accounts.", comment: "EBT multiple accounts error")
        case .ebtPolicyRejected, .notEBTCard, .ebtCardNDaysLimit, .ebtCardNHoursLimit:
            return NSLocalizedString("Unable to add card. Try again later.", comment: "EBT general error")
            
        // WIC Messages
        case .notWICCard:
            return NSLocalizedString("This doesn't appear to be a valid WIC card.", comment: "Invalid WIC card")
        case .incorrectCard:
            return NSLocalizedString("Please check your card information and try again.", comment: "Incorrect WIC card")
        case .wicPolicyRejected:
            return NSLocalizedString("Unable to add WIC card. Try again later.", comment: "WIC policy rejected")
        case .cardInTooManyAccounts:
            return NSLocalizedString("This card is linked to too many accounts.", comment: "WIC multiple accounts")
        case .noBalance, .getBalanceFailed:
            return NSLocalizedString("Unable to check card balance. Try again later.", comment: "WIC balance error")
        case .incorrectPin:
            return NSLocalizedString("Incorrect PIN. Please try again.", comment: "WIC incorrect PIN")
        case .pinBlock:
            return NSLocalizedString("PIN entry is temporarily blocked.", comment: "WIC PIN blocked")
        case .pinRetryExceeded:
            return NSLocalizedString("Too many PIN attempts. Please wait and try again.", comment: "WIC PIN retry exceeded")
        case .invalidPaymentProcessor:
            return NSLocalizedString("Payment processor error. Try again later.", comment: "WIC processor error")
            
        // DS/Benefit Messages
        case .duplicateDSCardBenefit:
            return NSLocalizedString("This card is already saved to your account.", comment: "Duplicate DS benefit card")
        case .dsInvalidType:
            return NSLocalizedString("This card type is not supported.", comment: "DS invalid type")
        case .dsCardNotActivated:
            return NSLocalizedString("This card needs to be activated. Contact your benefits provider.", comment: "DS not activated")
        case .dsProgramExpired:
            return NSLocalizedString("This program is no longer available.", comment: "DS program expired - CORRECTED MESSAGE")
        case .expiredCardInactiveProgramExpired:
            return NSLocalizedString("This card and program are no longer active.", comment: "DS card and program expired")
        case .dsBenefitCardNumberPinMismatch:
            return NSLocalizedString("Card number and PIN don't match. Please check and try again.", comment: "DS number/PIN mismatch")
        case .dsBenefitCardIneligible:
            return NSLocalizedString("This card is not eligible for online use.", comment: "DS card ineligible")
        case .dsBenefitInfoError:
            return NSLocalizedString("Unable to verify card information. Try again later.", comment: "DS info error")
        case .dsBenefitCardDobError:
            return NSLocalizedString("Date of birth doesn't match. Please check and try again.", comment: "DS DOB error")
        case .dsBenefitCardPostalCodeError:
            return NSLocalizedString("ZIP code doesn't match. Please check and try again.", comment: "DS postal code error")
        case .dsBenefitCardInAnotherAccount:
            return NSLocalizedString("This card is already linked to another account.", comment: "DS in another account")
        case .dsCardLost:
            return NSLocalizedString("This card has been reported lost. Contact your benefits provider.", comment: "DS card lost")
        case .dsCardStolen:
            return NSLocalizedString("This card has been reported stolen. Contact your benefits provider.", comment: "DS card stolen")
        case .dsCardFrozen:
            return NSLocalizedString("This card is temporarily frozen. Contact your benefits provider.", comment: "DS card frozen")
        }
    }
    
    // UNIFIED FACTORY METHOD
    static func fromErrorCode(_ errorCode: String) -> PaymentErrors? {
        return PaymentErrors.allCases.first { $0.rawValue == errorCode }
    }
    
    // UNIFIED ERROR LOGGING
    func logError(operation: GraphQLOperation, additionalInfo: [String: Any]? = nil) {
        WalletErrorLoggingService.shared.logError(
            error: self,
            operation: operation,
            paymentType: self.paymentType,
            additionalInfo: additionalInfo
        )
    }
}

// PAYMENT TYPE ENUM
enum PaymentType: String, CaseIterable {
    case creditCard = "credit_card"
    case giftCard = "gift_card"
    case ebtCard = "ebt_card"
    case wicCard = "wic_card"
    case dsBenefitCard = "ds_benefit_card"
    case paypal = "paypal"
}

// GRAPHQL OPERATION ENUM
enum GraphQLOperation: String {
    case addCreditCard = "AddCreditCard"
    case addGiftCard = "AddGiftCard"
    case addEBTCard = "AddEBTCard"
    case verifyWicCard = "VerifyWicCard"
    case addDSCard = "AddDSCard"
    case createPayPalBA = "createPayPalBA"
}

// UNIFIED ERROR LOGGING SERVICE
class WalletErrorLoggingService {
    static let shared = WalletErrorLoggingService()
    
    func logError(
        error: PaymentErrors,
        operation: GraphQLOperation,
        paymentType: PaymentType,
        additionalInfo: [String: Any]? = nil
    ) {
        let logData: [String: Any] = [
            "error_code": error.rawValue,
            "error_message": error.localizedMessage,
            "payment_type": paymentType.rawValue,
            "graphql_operation": operation.rawValue,
            "platform": "ios",
            "timestamp": Date().timeIntervalSince1970,
            "additional_info": additionalInfo ?? [:]
        ]
        
        // Send to logging service
        LoggingManager.shared.logEvent("wallet_payment_error", data: logData)
    }
}
```

### **Android Implementation**

```kotlin
// PaymentErrors.kt - UNIFIED ERROR ENUM
enum class PaymentErrors(
    val errorCode: String,
    val messageRes: Int,
    val paymentType: PaymentType
) {
    // Credit Card Errors
    AVS_REJECTED("ERROR_AVS_REJECTED", R.string.payment_methods_avs_error, PaymentType.CREDIT_CARD),
    CARD_EXPIRED("ERROR_CARD_EXPIRED", R.string.payment_methods_avs_error, PaymentType.CREDIT_CARD),
    CREDENTIAL_DECLINED("ERROR_CREDENTIAL_DECLINED", R.string.payment_methods_avs_error, PaymentType.CREDIT_CARD),
    CARD_LIMIT_REACHED("ERROR_CARD_LIMIT_REACHED", R.string.payment_methods_cc_limit_reached_error, PaymentType.CREDIT_CARD),
    CC_POLICY_REJECTED("ERROR_CC_POLICY_REJECTED", R.string.payment_methods_policy_rejected_error, PaymentType.CREDIT_CARD),
    INSTRUMENT_BLOCKED("ERROR_INSTRUMENT_BLOCKED", R.string.payment_methods_instrument_blocked_error, PaymentType.CREDIT_CARD),
    INVALID_NAME("ERROR_INVALID_NAME", R.string.payment_methods_invalid_name_error, PaymentType.CREDIT_CARD),
    DS_CARD_LIMIT_REACHED("ERROR_DS_CARD_LIMIT_REACHED", R.string.payment_methods_hsa_fsa_limit_reached_error, PaymentType.CREDIT_CARD),

    // Gift Card Errors
    DUPLICATE_GIFTCARD("ERROR_DUPLICATE_GIFTCARD", R.string.payment_methods_duplicate_giftcard_error, PaymentType.GIFT_CARD),
    GIFTCARD_BALANCE_ZERO("ERROR_GIFTCARD_BALANCE_ZERO", R.string.payment_methods_giftcard_balance_zero, PaymentType.GIFT_CARD),
    NOT_GIFT_CARD("ERROR_NOT_GIFT_CARD", R.string.payment_methods_not_gift_card, PaymentType.GIFT_CARD),
    PROVISION_LINK_EXPIRED("ERROR_PROVISION_LINK_EXPIRED", R.string.payment_methods_provision_expired, PaymentType.GIFT_CARD),
    GC_DECRYPT_ERROR("ERROR_GC_DECRYPT_ERROR", R.string.payment_methods_gc_decrypt_error, PaymentType.GIFT_CARD),
    DUPLICATE_DS_CARD("ERROR_DUPLICATE_DS_CARD", R.string.payment_methods_duplicate_ds_card, PaymentType.GIFT_CARD),
    DS_IN_STORE_CARD_ONLY("ERROR_DS_IN_STORE_CARD_ONLY", R.string.payment_methods_ds_in_store_only, PaymentType.GIFT_CARD),

    // EBT Card Errors
    EBT_CARD_TOO_MANY_ACCOUNTS("ERROR_EBT_CARD_IS_IN_TOO_MANY_OTHER_ACCOUNTS", R.string.payment_methods_ebt_too_many_accounts, PaymentType.EBT_CARD),
    EBT_POLICY_REJECTED("ERROR_EBT_POLICY_REJECTED", R.string.payment_methods_ebt_policy_rejected, PaymentType.EBT_CARD), // FIXED: Removed prefix
    NOT_EBT_CARD("ERROR_NOT_EBT_CARD", R.string.payment_methods_not_ebt_card, PaymentType.EBT_CARD),
    EBT_CARD_N_DAYS_LIMIT("ERROR_EBT_CARD_N_DAYS_LIMIT", R.string.payment_methods_ebt_days_limit, PaymentType.EBT_CARD),
    EBT_CARD_N_HOURS_LIMIT("ERROR_EBT_CARD_N_HOURS_LIMIT", R.string.payment_methods_ebt_hours_limit, PaymentType.EBT_CARD),

    // WIC Card Errors
    NOT_WIC_CARD("ERROR_NOT_WIC_CARD", R.string.payment_methods_not_wic_card, PaymentType.WIC_CARD),
    INCORRECT_CARD("INCORRECT_CARD", R.string.payment_methods_incorrect_card, PaymentType.WIC_CARD),
    WIC_POLICY_REJECTED("ERROR_WIC_POLICY_REJECTED", R.string.payment_methods_wic_policy_rejected, PaymentType.WIC_CARD),
    CARD_TOO_MANY_ACCOUNTS("CARD_IS_IN_TOO_MANY_OTHER_ACCOUNTS", R.string.payment_methods_card_too_many_accounts, PaymentType.WIC_CARD),
    NO_BALANCE("NO_BALANCE", R.string.payment_methods_no_balance, PaymentType.WIC_CARD),
    GET_BALANCE_FAILED("GET_BALANCE_FAILED", R.string.payment_methods_get_balance_failed, PaymentType.WIC_CARD),
    INCORRECT_PIN("INCORRECT_PIN", R.string.payment_methods_incorrect_pin, PaymentType.WIC_CARD),
    PIN_BLOCK("PIN_BLOCK", R.string.payment_methods_pin_block, PaymentType.WIC_CARD),
    PIN_RETRY_EXCEEDED("PIN_RETRY_EXCEEDED", R.string.payment_methods_pin_retry_exceeded, PaymentType.WIC_CARD),
    INVALID_PAYMENT_PROCESSOR("INVALID_PAYMENT_PROCESSOR", R.string.payment_methods_invalid_processor, PaymentType.WIC_CARD),

    // DS/Benefit Card Errors
    DS_INVALID_TYPE("ERROR_DS_INVALID_TYPE", R.string.payment_methods_ds_invalid_type, PaymentType.DS_BENEFIT_CARD),
    DS_CARD_NOT_ACTIVATED("ERROR_DS_CARD_NOT_ACTIVATED", R.string.payment_methods_ds_not_activated, PaymentType.DS_BENEFIT_CARD),
    DS_PROGRAM_EXPIRED("ERROR_DS_PROGRAM_EXPIRED", R.string.payment_methods_ds_program_expired, PaymentType.DS_BENEFIT_CARD), // FIXED: Updated to program message
    DS_CARD_PROGRAM_EXPIRED("ERROR_EXPIRED_CARD_INACTIVE_CARD_PROGRAM_EXPIRED", R.string.payment_methods_ds_card_program_expired, PaymentType.DS_BENEFIT_CARD),
    DS_CARD_PIN_MISMATCH("ERROR_DS_BENEFIT_CARD_NUMBER_PIN_MISMATCH", R.string.payment_methods_ds_pin_mismatch, PaymentType.DS_BENEFIT_CARD),
    DS_CARD_INELIGIBLE("ERROR_DS_BENEFIT_CARD_INELIGIBLE", R.string.payment_methods_ds_ineligible, PaymentType.DS_BENEFIT_CARD),
    DS_INFO_ERROR("ERROR_DS_BENEFIT_INFO_ERROR", R.string.payment_methods_ds_info_error, PaymentType.DS_BENEFIT_CARD),
    DS_DOB_ERROR("ERROR_DS_BENEFIT_CARD_DOB_ERROR", R.string.payment_methods_ds_dob_error, PaymentType.DS_BENEFIT_CARD),
    DS_POSTAL_ERROR("ERROR_DS_BENEFIT_CARD_POSTALCODE_ERROR", R.string.payment_methods_ds_postal_error, PaymentType.DS_BENEFIT_CARD),
    DS_IN_ANOTHER_ACCOUNT("ERROR_DS_BENEFIT_CARD_IN_ANOTHER_ACCOUNT", R.string.payment_methods_ds_another_account, PaymentType.DS_BENEFIT_CARD),
    DS_CARD_LOST("ERROR_DS_CARD_LOST", R.string.payment_methods_ds_card_lost, PaymentType.DS_BENEFIT_CARD),
    DS_CARD_STOLEN("ERROR_DS_CARD_STOLEN", R.string.payment_methods_ds_card_stolen, PaymentType.DS_BENEFIT_CARD),
    DS_CARD_FROZEN("ERROR_DS_CARD_FROZEN", R.string.payment_methods_ds_card_frozen, PaymentType.DS_BENEFIT_CARD);

    companion object {
        fun fromErrorCode(errorCode: String): PaymentErrors? = 
            values().find { it.errorCode == errorCode }
            
        fun getAllByPaymentType(paymentType: PaymentType): List<PaymentErrors> =
            values().filter { it.paymentType == paymentType }
    }
    
    // UNIFIED ERROR LOGGING
    fun logError(
        operation: GraphQLOperation,
        context: Context,
        additionalInfo: Map<String, Any>? = null
    ) {
        WalletErrorLoggingManager.logError(
            error = this,
            operation = operation,
            context = context,
            additionalInfo = additionalInfo
        )
    }
    
    // GET LOCALIZED MESSAGE
    fun getErrorMessage(context: Context): String {
        return context.getString(messageRes)
    }
}

// PAYMENT TYPE ENUM
enum class PaymentType(val type: String) {
    CREDIT_CARD("credit_card"),
    GIFT_CARD("gift_card"),
    EBT_CARD("ebt_card"),
    WIC_CARD("wic_card"),
    DS_BENEFIT_CARD("ds_benefit_card"),
    PAYPAL("paypal")
}

// GRAPHQL OPERATION ENUM
enum class GraphQLOperation(val operation: String) {
    ADD_CREDIT_CARD("AddCreditCard"),
    ADD_GIFT_CARD("AddGiftCard"),
    ADD_EBT_CARD("AddEBTCard"),
    VERIFY_WIC_CARD("VerifyWicCard"),
    ADD_DS_CARD("AddDSCard"),
    CREATE_PAYPAL_BA("createPayPalBA")
}

// UNIFIED ERROR LOGGING MANAGER
object WalletErrorLoggingManager {
    fun logError(
        error: PaymentErrors,
        operation: GraphQLOperation,
        context: Context,
        additionalInfo: Map<String, Any>? = null
    ) {
        val logData = mapOf(
            "error_code" to error.errorCode,
            "error_message" to error.getErrorMessage(context),
            "payment_type" to error.paymentType.type,
            "graphql_operation" to operation.operation,
            "platform" to "android",
            "timestamp" to System.currentTimeMillis(),
            "additional_info" to (additionalInfo ?: emptyMap())
        )
        
        LoggingManager.logEvent("wallet_payment_error", logData)
    }
}
```

### **Web Implementation**

```typescript
// paymentErrors.ts - UNIFIED ERROR ENUM
export enum PaymentType {
  CREDIT_CARD = 'credit_card',
  GIFT_CARD = 'gift_card',
  EBT_CARD = 'ebt_card',
  WIC_CARD = 'wic_card',
  DS_BENEFIT_CARD = 'ds_benefit_card',
  PAYPAL = 'paypal'
}

export enum GraphQLOperation {
  ADD_CREDIT_CARD = 'AddCreditCard',
  ADD_GIFT_CARD = 'AddGiftCard',
  ADD_EBT_CARD = 'AddEBTCard',
  VERIFY_WIC_CARD = 'VerifyWicCard',
  ADD_DS_CARD = 'AddDSCard',
  CREATE_PAYPAL_BA = 'createPayPalBA'
}

export enum PaymentErrors {
  // Credit Card Errors
  AVS_REJECTED = 'ERROR_AVS_REJECTED',
  CARD_EXPIRED = 'ERROR_CARD_EXPIRED',
  CREDENTIAL_DECLINED = 'ERROR_CREDENTIAL_DECLINED',
  CARD_LIMIT_REACHED = 'ERROR_CARD_LIMIT_REACHED',
  CC_POLICY_REJECTED = 'ERROR_CC_POLICY_REJECTED',
  INSTRUMENT_BLOCKED = 'ERROR_INSTRUMENT_BLOCKED',
  INVALID_NAME = 'ERROR_INVALID_NAME',
  DS_CARD_LIMIT_REACHED = 'ERROR_DS_CARD_LIMIT_REACHED',

  // Gift Card Errors
  DUPLICATE_GIFTCARD = 'ERROR_DUPLICATE_GIFTCARD',
  GIFTCARD_BALANCE_ZERO = 'ERROR_GIFTCARD_BALANCE_ZERO',
  NOT_GIFT_CARD = 'ERROR_NOT_GIFT_CARD',
  PROVISION_LINK_EXPIRED = 'ERROR_PROVISION_LINK_EXPIRED',
  GC_DECRYPT_ERROR = 'ERROR_GC_DECRYPT_ERROR',
  DUPLICATE_DS_CARD = 'ERROR_DUPLICATE_DS_CARD',
  DS_IN_STORE_CARD_ONLY = 'ERROR_DS_IN_STORE_CARD_ONLY',

  // EBT Card Errors
  EBT_CARD_TOO_MANY_ACCOUNTS = 'ERROR_EBT_CARD_IS_IN_TOO_MANY_OTHER_ACCOUNTS',
  EBT_POLICY_REJECTED = 'ERROR_EBT_POLICY_REJECTED',
  NOT_EBT_CARD = 'ERROR_NOT_EBT_CARD',
  EBT_CARD_N_DAYS_LIMIT = 'ERROR_EBT_CARD_N_DAYS_LIMIT',
  EBT_CARD_N_HOURS_LIMIT = 'ERROR_EBT_CARD_N_HOURS_LIMIT',

  // WIC Card Errors
  NOT_WIC_CARD = 'ERROR_NOT_WIC_CARD',
  INCORRECT_CARD = 'INCORRECT_CARD',
  WIC_POLICY_REJECTED = 'ERROR_WIC_POLICY_REJECTED',
  CARD_TOO_MANY_ACCOUNTS = 'CARD_IS_IN_TOO_MANY_OTHER_ACCOUNTS',
  NO_BALANCE = 'NO_BALANCE',
  GET_BALANCE_FAILED = 'GET_BALANCE_FAILED',
  INCORRECT_PIN = 'INCORRECT_PIN',
  PIN_BLOCK = 'PIN_BLOCK',
  PIN_RETRY_EXCEEDED = 'PIN_RETRY_EXCEEDED',
  INVALID_PAYMENT_PROCESSOR = 'INVALID_PAYMENT_PROCESSOR',

  // DS/Benefit Card Errors
  DS_INVALID_TYPE = 'ERROR_DS_INVALID_TYPE',
  DS_CARD_NOT_ACTIVATED = 'ERROR_DS_CARD_NOT_ACTIVATED',
  DS_PROGRAM_EXPIRED = 'ERROR_DS_PROGRAM_EXPIRED',
  DS_CARD_PROGRAM_EXPIRED = 'ERROR_EXPIRED_CARD_INACTIVE_CARD_PROGRAM_EXPIRED',
  DS_CARD_PIN_MISMATCH = 'ERROR_DS_BENEFIT_CARD_NUMBER_PIN_MISMATCH',
  DS_CARD_INELIGIBLE = 'ERROR_DS_BENEFIT_CARD_INELIGIBLE',
  DS_INFO_ERROR = 'ERROR_DS_BENEFIT_INFO_ERROR',
  DS_DOB_ERROR = 'ERROR_DS_BENEFIT_CARD_DOB_ERROR',
  DS_POSTAL_ERROR = 'ERROR_DS_BENEFIT_CARD_POSTALCODE_ERROR',
  DS_IN_ANOTHER_ACCOUNT = 'ERROR_DS_BENEFIT_CARD_IN_ANOTHER_ACCOUNT',
  DS_CARD_LOST = 'ERROR_DS_CARD_LOST',
  DS_CARD_STOLEN = 'ERROR_DS_CARD_STOLEN',
  DS_CARD_FROZEN = 'ERROR_DS_CARD_FROZEN'
}

export interface PaymentErrorDefinition {
  errorCode: string;
  errorMessage: string;
  paymentType: PaymentType;
}

// UNIFIED ERROR MAPPINGS
export const PAYMENT_ERROR_DEFINITIONS: Record<PaymentErrors, PaymentErrorDefinition> = {
  // Credit Card Mappings
  [PaymentErrors.AVS_REJECTED]: {
    errorCode: PaymentErrors.AVS_REJECTED,
    errorMessage: AVS_ERROR_MESSAGE,
    paymentType: PaymentType.CREDIT_CARD
  },
  [PaymentErrors.CARD_EXPIRED]: {
    errorCode: PaymentErrors.CARD_EXPIRED,
    errorMessage: AVS_ERROR_MESSAGE,
    paymentType: PaymentType.CREDIT_CARD
  },
  [PaymentErrors.CREDENTIAL_DECLINED]: {
    errorCode: PaymentErrors.CREDENTIAL_DECLINED,
    errorMessage: AVS_ERROR_MESSAGE,
    paymentType: PaymentType.CREDIT_CARD
  },
  [PaymentErrors.CARD_LIMIT_REACHED]: {
    errorCode: PaymentErrors.CARD_LIMIT_REACHED,
    errorMessage: CC_LIMIT_REACHED_ERROR_MESSAGE,
    paymentType: PaymentType.CREDIT_CARD
  },
  [PaymentErrors.CC_POLICY_REJECTED]: {
    errorCode: PaymentErrors.CC_POLICY_REJECTED,
    errorMessage: POLICY_REJECTED_ERROR_MESSAGE,
    paymentType: PaymentType.CREDIT_CARD
  },
  [PaymentErrors.INSTRUMENT_BLOCKED]: {
    errorCode: PaymentErrors.INSTRUMENT_BLOCKED,
    errorMessage: ERROR_INSTRUMENT_BLOCKED_MESSAGE,
    paymentType: PaymentType.CREDIT_CARD
  },
  [PaymentErrors.INVALID_NAME]: {
    errorCode: PaymentErrors.INVALID_NAME,
    errorMessage: ERROR_INVALID_NAME,
    paymentType: PaymentType.CREDIT_CARD
  },
  [PaymentErrors.DS_CARD_LIMIT_REACHED]: {
    errorCode: PaymentErrors.DS_CARD_LIMIT_REACHED,
    errorMessage: HSA_FSA_LIMIT_REACHED_ERROR_MESSAGE,
    paymentType: PaymentType.CREDIT_CARD
  },
  
  // Gift Card Mappings
  [PaymentErrors.DUPLICATE_GIFTCARD]: {
    errorCode: PaymentErrors.DUPLICATE_GIFTCARD,
    errorMessage: DUPLICATE_GIFTCARD_ERROR_MESSAGE, // UX decision pending
    paymentType: PaymentType.GIFT_CARD
  },
  [PaymentErrors.GIFTCARD_BALANCE_ZERO]: {
    errorCode: PaymentErrors.GIFTCARD_BALANCE_ZERO,
    errorMessage: GIFTCARD_BALANCE_ZERO_MESSAGE,
    paymentType: PaymentType.GIFT_CARD
  },
  [PaymentErrors.NOT_GIFT_CARD]: {
    errorCode: PaymentErrors.NOT_GIFT_CARD,
    errorMessage: NOT_GIFT_CARD_MESSAGE,
    paymentType: PaymentType.GIFT_CARD
  },
  [PaymentErrors.PROVISION_LINK_EXPIRED]: {
    errorCode: PaymentErrors.PROVISION_LINK_EXPIRED,
    errorMessage: PROVISION_LINK_EXPIRED_MESSAGE,
    paymentType: PaymentType.GIFT_CARD
  },
  [PaymentErrors.GC_DECRYPT_ERROR]: {
    errorCode: PaymentErrors.GC_DECRYPT_ERROR,
    errorMessage: GC_DECRYPT_ERROR_MESSAGE,
    paymentType: PaymentType.GIFT_CARD
  },
  [PaymentErrors.DUPLICATE_DS_CARD]: {
    errorCode: PaymentErrors.DUPLICATE_DS_CARD,
    errorMessage: DUPLICATE_DS_CARD_MESSAGE,
    paymentType: PaymentType.GIFT_CARD
  },
  [PaymentErrors.DS_IN_STORE_CARD_ONLY]: {
    errorCode: PaymentErrors.DS_IN_STORE_CARD_ONLY,
    errorMessage: DS_IN_STORE_CARD_ONLY_MESSAGE,
    paymentType: PaymentType.GIFT_CARD
  },

  // EBT Card Mappings
  [PaymentErrors.EBT_CARD_TOO_MANY_ACCOUNTS]: {
    errorCode: PaymentErrors.EBT_CARD_TOO_MANY_ACCOUNTS,
    errorMessage: EBT_TOO_MANY_ACCOUNTS_MESSAGE,
    paymentType: PaymentType.EBT_CARD
  },
  [PaymentErrors.EBT_POLICY_REJECTED]: {
    errorCode: PaymentErrors.EBT_POLICY_REJECTED,
    errorMessage: EBT_POLICY_REJECTED_MESSAGE,
    paymentType: PaymentType.EBT_CARD
  },
  [PaymentErrors.NOT_EBT_CARD]: {
    errorCode: PaymentErrors.NOT_EBT_CARD,
    errorMessage: NOT_EBT_CARD_MESSAGE,
    paymentType: PaymentType.EBT_CARD
  },
  [PaymentErrors.EBT_CARD_N_DAYS_LIMIT]: {
    errorCode: PaymentErrors.EBT_CARD_N_DAYS_LIMIT,
    errorMessage: EBT_DAYS_LIMIT_MESSAGE,
    paymentType: PaymentType.EBT_CARD
  },
  [PaymentErrors.EBT_CARD_N_HOURS_LIMIT]: {
    errorCode: PaymentErrors.EBT_CARD_N_HOURS_LIMIT,
    errorMessage: EBT_HOURS_LIMIT_MESSAGE,
    paymentType: PaymentType.EBT_CARD
  },

  // WIC Card Mappings
  [PaymentErrors.NOT_WIC_CARD]: {
    errorCode: PaymentErrors.NOT_WIC_CARD,
    errorMessage: NOT_WIC_CARD_MESSAGE,
    paymentType: PaymentType.WIC_CARD
  },
  [PaymentErrors.INCORRECT_CARD]: {
    errorCode: PaymentErrors.INCORRECT_CARD,
    errorMessage: INCORRECT_CARD_MESSAGE,
    paymentType: PaymentType.WIC_CARD
  },
  [PaymentErrors.WIC_POLICY_REJECTED]: {
    errorCode: PaymentErrors.WIC_POLICY_REJECTED,
    errorMessage: WIC_POLICY_REJECTED_MESSAGE,
    paymentType: PaymentType.WIC_CARD
  },
  [PaymentErrors.CARD_TOO_MANY_ACCOUNTS]: {
    errorCode: PaymentErrors.CARD_TOO_MANY_ACCOUNTS,
    errorMessage: CARD_TOO_MANY_ACCOUNTS_MESSAGE,
    paymentType: PaymentType.WIC_CARD
  },
  [PaymentErrors.NO_BALANCE]: {
    errorCode: PaymentErrors.NO_BALANCE,
    errorMessage: NO_BALANCE_MESSAGE,
    paymentType: PaymentType.WIC_CARD
  },
  [PaymentErrors.GET_BALANCE_FAILED]: {
    errorCode: PaymentErrors.GET_BALANCE_FAILED,
    errorMessage: GET_BALANCE_FAILED_MESSAGE,
    paymentType: PaymentType.WIC_CARD
  },
  [PaymentErrors.INCORRECT_PIN]: {
    errorCode: PaymentErrors.INCORRECT_PIN,
    errorMessage: INCORRECT_PIN_MESSAGE,
    paymentType: PaymentType.WIC_CARD
  },
  [PaymentErrors.PIN_BLOCK]: {
    errorCode: PaymentErrors.PIN_BLOCK,
    errorMessage: PIN_BLOCK_MESSAGE,
    paymentType: PaymentType.WIC_CARD
  },
  [PaymentErrors.PIN_RETRY_EXCEEDED]: {
    errorCode: PaymentErrors.PIN_RETRY_EXCEEDED,
    errorMessage: PIN_RETRY_EXCEEDED_MESSAGE,
    paymentType: PaymentType.WIC_CARD
  },
  [PaymentErrors.INVALID_PAYMENT_PROCESSOR]: {
    errorCode: PaymentErrors.INVALID_PAYMENT_PROCESSOR,
    errorMessage: INVALID_PROCESSOR_MESSAGE,
    paymentType: PaymentType.WIC_CARD
  },

  // DS/Benefit Card Mappings
  [PaymentErrors.DS_INVALID_TYPE]: {
    errorCode: PaymentErrors.DS_INVALID_TYPE,
    errorMessage: DS_INVALID_TYPE_MESSAGE,
    paymentType: PaymentType.DS_BENEFIT_CARD
  },
  [PaymentErrors.DS_CARD_NOT_ACTIVATED]: {
    errorCode: PaymentErrors.DS_CARD_NOT_ACTIVATED,
    errorMessage: DS_NOT_ACTIVATED_MESSAGE,
    paymentType: PaymentType.DS_BENEFIT_CARD
  },
  [PaymentErrors.DS_PROGRAM_EXPIRED]: {
    errorCode: PaymentErrors.DS_PROGRAM_EXPIRED,
    errorMessage: DS_PROGRAM_EXPIRED_MESSAGE, // CORRECTED: Program not card
    paymentType: PaymentType.DS_BENEFIT_CARD
  },
  [PaymentErrors.DS_CARD_PROGRAM_EXPIRED]: {
    errorCode: PaymentErrors.DS_CARD_PROGRAM_EXPIRED,
    errorMessage: DS_CARD_PROGRAM_EXPIRED_MESSAGE,
    paymentType: PaymentType.DS_BENEFIT_CARD
  },
  [PaymentErrors.DS_CARD_PIN_MISMATCH]: {
    errorCode: PaymentErrors.DS_CARD_PIN_MISMATCH,
    errorMessage: DS_PIN_MISMATCH_MESSAGE,
    paymentType: PaymentType.DS_BENEFIT_CARD
  },
  [PaymentErrors.DS_CARD_INELIGIBLE]: {
    errorCode: PaymentErrors.DS_CARD_INELIGIBLE,
    errorMessage: DS_INELIGIBLE_MESSAGE,
    paymentType: PaymentType.DS_BENEFIT_CARD
  },
  [PaymentErrors.DS_INFO_ERROR]: {
    errorCode: PaymentErrors.DS_INFO_ERROR,
    errorMessage: DS_INFO_ERROR_MESSAGE,
    paymentType: PaymentType.DS_BENEFIT_CARD
  },
  [PaymentErrors.DS_DOB_ERROR]: {
    errorCode: PaymentErrors.DS_DOB_ERROR,
    errorMessage: DS_DOB_ERROR_MESSAGE,
    paymentType: PaymentType.DS_BENEFIT_CARD
  },
  [PaymentErrors.DS_POSTAL_ERROR]: {
    errorCode: PaymentErrors.DS_POSTAL_ERROR,
    errorMessage: DS_POSTAL_ERROR_MESSAGE,
    paymentType: PaymentType.DS_BENEFIT_CARD
  },
  [PaymentErrors.DS_IN_ANOTHER_ACCOUNT]: {
    errorCode: PaymentErrors.DS_IN_ANOTHER_ACCOUNT,
    errorMessage: DS_ANOTHER_ACCOUNT_MESSAGE,
    paymentType: PaymentType.DS_BENEFIT_CARD
  },
  [PaymentErrors.DS_CARD_LOST]: {
    errorCode: PaymentErrors.DS_CARD_LOST,
    errorMessage: DS_CARD_LOST_MESSAGE,
    paymentType: PaymentType.DS_BENEFIT_CARD
  },
  [PaymentErrors.DS_CARD_STOLEN]: {
    errorCode: PaymentErrors.DS_CARD_STOLEN,
    errorMessage: DS_CARD_STOLEN_MESSAGE,
    paymentType: PaymentType.DS_BENEFIT_CARD
  },
  [PaymentErrors.DS_CARD_FROZEN]: {
    errorCode: PaymentErrors.DS_CARD_FROZEN,
    errorMessage: DS_CARD_FROZEN_MESSAGE,
    paymentType: PaymentType.DS_BENEFIT_CARD
  }
};

// UNIFIED UTILITY FUNCTIONS
export function getPaymentErrorFromCode(errorCode: string): PaymentErrors | null {
  const entry = Object.entries(PAYMENT_ERROR_DEFINITIONS).find(
    ([_, definition]) => definition.errorCode === errorCode
  );
  return entry ? entry[0] as PaymentErrors : null;
}

export function getPaymentErrorDefinition(error: PaymentErrors): PaymentErrorDefinition {
  return PAYMENT_ERROR_DEFINITIONS[error];
}

export function getErrorsByPaymentType(paymentType: PaymentType): PaymentErrors[] {
  return Object.keys(PAYMENT_ERROR_DEFINITIONS)
    .filter(key => PAYMENT_ERROR_DEFINITIONS[key as PaymentErrors].paymentType === paymentType)
    .map(key => key as PaymentErrors);
}

export function logPaymentError(
  error: PaymentErrors,
  operation: GraphQLOperation,
  additionalInfo?: Record<string, any>
) {
  const definition = getPaymentErrorDefinition(error);
  
  const logData = {
    error_code: definition.errorCode,
    error_message: definition.errorMessage,
    payment_type: definition.paymentType,
    graphql_operation: operation,
    platform: 'web',
    timestamp: Date.now(),
    additional_info: additionalInfo || {}
  };
  
  WalletErrorLoggingService.logError('wallet_payment_error', logData);
}

// REPLACEMENT FOR card-error-helpers.ts
export function getCreditCardErrorMessage(errorCode: string): string {
  const error = getPaymentErrorFromCode(errorCode);
  if (error && PAYMENT_ERROR_DEFINITIONS[error].paymentType === PaymentType.CREDIT_CARD) {
    return PAYMENT_ERROR_DEFINITIONS[error].errorMessage;
  }
  return DEFAULT_CREDIT_CARD_ERROR_MESSAGE;
}

export function getGiftCardErrorMessage(errorCode: string): string {
  const error = getPaymentErrorFromCode(errorCode);
  if (error && PAYMENT_ERROR_DEFINITIONS[error].paymentType === PaymentType.GIFT_CARD) {
    return PAYMENT_ERROR_DEFINITIONS[error].errorMessage;
  }
  return DEFAULT_GIFT_CARD_ERROR_MESSAGE;
}

export function getEBTCardErrorMessage(errorCode: string): string {
  const error = getPaymentErrorFromCode(errorCode);
  if (error && PAYMENT_ERROR_DEFINITIONS[error].paymentType === PaymentType.EBT_CARD) {
    return PAYMENT_ERROR_DEFINITIONS[error].errorMessage;
  }
  return DEFAULT_EBT_ERROR_MESSAGE;
}

export function getWICCardErrorMessage(errorCode: string): string {
  const error = getPaymentErrorFromCode(errorCode);
  if (error && PAYMENT_ERROR_DEFINITIONS[error].paymentType === PaymentType.WIC_CARD) {
    return PAYMENT_ERROR_DEFINITIONS[error].errorMessage;
  }
  return DEFAULT_WIC_ERROR_MESSAGE;
}

export function getDSBenefitCardErrorMessage(errorCode: string): string {
  const error = getPaymentErrorFromCode(errorCode);
  if (error && PAYMENT_ERROR_DEFINITIONS[error].paymentType === PaymentType.DS_BENEFIT_CARD) {
    return PAYMENT_ERROR_DEFINITIONS[error].errorMessage;
  }
  return DEFAULT_DS_ERROR_MESSAGE;
}
```

---

## 🎯 **KEY BENEFITS OF UNIFIED ARCHITECTURE**

### **1. Single Source of Truth**
- ✅ One enum per platform with all 67 error codes
- ✅ Consistent error handling across all payment types
- ✅ Unified interface and method signatures

### **2. Reduced Maintenance Overhead**
- ✅ Add new error codes in one place
- ✅ Update error messages in one enum
- ✅ Single test suite per platform

### **3. Type Safety & Consistency**
- ✅ Compile-time validation of error codes
- ✅ Consistent API across all payment types
- ✅ Prevents mapping errors

### **4. Improved Developer Experience**
- ✅ Auto-completion for all error codes
- ✅ Clear categorization by payment type
- ✅ Uniform error logging interface

### **5. Cross-Platform Alignment**
- ✅ Same enum structure across iOS, Android, Web
- ✅ Consistent error categorization
- ✅ Unified logging format

### **6. Future-Proof Design**
- ✅ Easy to add new payment types
- ✅ Scalable error categorization
- ✅ Backend message integration ready

---

## 📈 **IMPLEMENTATION IMPACT COMPARISON**

### **Current Separate Enum Approach:**
```
Files to Create/Modify per Platform:
❌ CreditCardErrors.swift/kt/ts (3 files)
❌ GiftCardErrors.swift/kt/ts (3 files)
❌ EBTCardErrors.swift/kt/ts (3 files)
❌ WICCardErrors.swift/kt/ts (3 files)
❌ DSBenefitCardErrors.swift/kt/ts (3 files)
❌ PayPalErrors.swift/kt/ts (3 files)
❌ 6 separate error logging implementations
Total: 21 files + 6 logging services = 27 components
```

### **Unified Architecture Approach:**
```
Files to Create/Modify per Platform:
✅ PaymentErrors.swift/kt/ts (3 files)
✅ PaymentType.swift/kt/ts (3 files)
✅ WalletErrorLoggingService.swift/kt/ts (3 files)
Total: 9 components (67% reduction!)
```

---

## 🚀 **MIGRATION STRATEGY**

### **Phase 1: Create Unified Architecture**
1. Create `PaymentErrors` enum with all 67 error codes
2. Create `PaymentType` enum for categorization
3. Create unified error logging service
4. Add backward compatibility methods

### **Phase 2: Update Existing Code**
1. Replace separate enum usages with unified enum
2. Update error handling to use payment type filtering
3. Migrate logging calls to unified service
4. Update GraphQL fragments to use unified approach

### **Phase 3: Clean Up**
1. Remove old separate enum files
2. Remove old error handling methods
3. Update documentation
4. Complete cross-platform testing

---

## 🔧 **PROPOSED TASK 1 ARCHITECTURE TICKETS**

### **Updated Ticket Structure:**

Instead of 21 tickets (7 APIs × 3 platforms), create:

### **🎫 TASK 1A: UNIFIED PAYMENT ERROR ARCHITECTURE (9 tickets)**
- **[iOS]** Create Unified PaymentErrors Architecture (8 pts)
- **[Android]** Create Unified PaymentErrors Architecture (8 pts)  
- **[Web]** Create Unified PaymentErrors Architecture (5 pts)
- **[iOS]** Migrate Existing Error Handling to Unified System (5 pts)
- **[Android]** Migrate Existing Error Handling to Unified System (5 pts)
- **[Web]** Migrate Existing Error Handling to Unified System (3 pts)
- **[iOS]** GraphQL Fragment Standardization (5 pts)
- **[Android]** GraphQL Fragment Standardization (5 pts)
- **[Web]** GraphQL Fragment Standardization (3 pts)

**Total: 47 story points (vs 91 with separate approach)**

---

## 🤔 **DECISION REQUIRED**

**Question:** Should we proceed with the **Unified PaymentError Architecture** approach or continue with the **Separate Enums** approach?

**Unified Architecture Benefits:**
- ✅ 48% reduction in story points (47 vs 91)
- ✅ 67% reduction in files to maintain (9 vs 27)
- ✅ Single source of truth for error handling
- ✅ Consistent API across all payment types
- ✅ Future-proof for new payment types

**Separate Enums Benefits:**
- ✅ Smaller, focused enums per payment type
- ✅ Easier to understand individual payment type errors
- ✅ Less initial architectural complexity

**Recommendation:** **Proceed with Unified PaymentError Architecture** for long-term maintainability and consistency.