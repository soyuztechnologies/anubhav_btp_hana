//namespace anubhav.db;
using { cuid, managed, temporal, Currency } from '@sap/cds/common';
using { anubhav.common } from './common';

context anubhav.db{
type Guid : String(32);

context master {
    entity businesspartner {
        key NODE_KEY : Guid;
        BP_ROLE	:String(2);
        EMAIL_ADDRESS :String(105);
        PHONE_NUMBER: String(32);
        FAX_NUMBER: String(32);
        WEB_ADDRESS:String(44);	
        ADDRESS_GUID: Association to address;	
        BP_ID: String(32);	
        COMPANY_NAME: String(250);
    }

    

    entity address {
        key NODE_KEY: Guid;
        CITY: String(44);
        POSTAL_CODE: String(8);
        STREET: String(44);
        BUILDING:String(128)  ;
        COUNTRY: String(44);
        ADDRESS_TYPE: String(44);
        VAL_START_DATE: Date;
        VAL_END_DATE:Date;
        LATITUDE: Decimal;
        LONGITUDE: Decimal;
        businesspartner: Association to one businesspartner on businesspartner.ADDRESS_GUID = $self;
    }

    entity test {
        key NODE_KEY: Guid;
        TEST: String(10)    ;
    }
    
    entity product {
        key NODE_KEY: Guid;
        PRODUCT_ID: String(28);
        TYPE_CODE: String(2);
        CATEGORY: String(32);
        DESCRIPTION: localized String(255);
        SUPPLIER_GUID: Association to master.businesspartner;
        TAX_TARIF_CODE: Integer;
        MEASURE_UNIT: String(2);
        WEIGHT_MEASURE	: Decimal;
        WEIGHT_UNIT: String(2);
        CURRENCY_CODE:String(4);
        PRICE: Decimal(15,2);
        WIDTH:Decimal;	
        DEPTH:Decimal;	
        HEIGHT:	Decimal;
        DIM_UNIT:String(2);

    }

    
    entity employees: cuid {
        nameFirst: String(40);
        nameMiddle: String(40);	
        nameLast: String(40);	
        nameInitials: String(40);	
        sex	: common.Gender;
        language: String(1);
        phoneNumber: common.PhoneNumber;
        email: common.Email;
        loginName: String(12);
        Currency: Currency;
        salaryAmount: common.AmountT;	
        accountNumber: String(16);	
        bankId: String(20);
        bankName: String(64);
    }

}



context transaction {
    
     entity purchaseorder: common.Amount, cuid {
            PO_ID: String(24);     	
            PARTNER_GUID: association to master.businesspartner;                      
            LIFECYCLE_STATUS: String(1);	
            OVERALL_STATUS: String(1);
            Items: Composition of many poitems on Items.PARENT_KEY = $self;
            NOTE: String(256);
     }

     entity poitems: common.Amount, cuid {
            PARENT_KEY: association to purchaseorder;
            PO_ITEM_POS: Integer;	
            PRODUCT_GUID: association to master.product;           	
              
     }

}



}

@cds.persistence.calcview
@cds.persistence.exists 
Entity ![CV_BP] {
key     ![NODE_KEY]: String(32)  @title: 'NODE_KEY: NODE_KEY' ; 
key     ![BP_ROLE]: String(2)  @title: 'BP_ROLE: BP_ROLE' ; 
key     ![COMPANY_NAME]: String(250)  @title: 'COMPANY_NAME: COMPANY_NAME' ; 
key     ![BP_ID]: String(32)  @title: 'BP_ID: BP_ID' ; 
key     ![CITY]: String(44)  @title: 'CITY: CITY' ; 
key     ![COUNTRY]: String(44)  @title: 'COUNTRY: COUNTRY' ; 
key     ![LATITUDE]: Decimal(34)  @title: 'LATITUDE: LATITUDE' ; 
key     ![LONGITUDE]: Decimal(34)  @title: 'LONGITUDE: LONGITUDE' ; 
}

@cds.persistence.calcview
@cds.persistence.exists 
Entity ![CV_PURCHASE] {
key     ![NODE_KEY]: String(32)  @title: 'NODE_KEY: NODE_KEY' ; 
key     ![BP_ROLE]: String(2)  @title: 'BP_ROLE: BP_ROLE' ; 
key     ![COMPANY_NAME]: String(250)  @title: 'COMPANY_NAME: COMPANY_NAME' ; 
key     ![BP_ID]: String(32)  @title: 'BP_ID: BP_ID' ; 
key     ![CITY]: String(44)  @title: 'CITY: CITY' ; 
key     ![COUNTRY]: String(44)  @title: 'COUNTRY: COUNTRY' ; 
key     ![PARTNER_GUID_NODE_KEY]: String(32)  @title: 'PARTNER_GUID_NODE_KEY: PARTNER_GUID_NODE_KEY' ; 
key     ![PO_ID]: String(24)  @title: 'PO_ID: PO_ID' ; 
key     ![LIFECYCLE_STATUS]: String(1)  @title: 'LIFECYCLE_STATUS: LIFECYCLE_STATUS' ; 
key     ![NOTE]: String(256)  @title: 'NOTE: NOTE' ; 
key     ![CURRENCY_CODE]: String(3)  @title: 'CURRENCY_CODE: CURRENCY_CODE' ; 
key     ![LATITUDE]: Decimal(34)  @title: 'LATITUDE: LATITUDE' ; 
key     ![LONGITUDE]: Decimal(34)  @title: 'LONGITUDE: LONGITUDE' ; 
key     ![PO_ITEM_POS]: Integer64  @title: 'PO_ITEM_POS: PO_ITEM_POS' ; 
key     ![GROSS_AMOUNT]: Decimal(15, 2)  @title: 'GROSS_AMOUNT: GROSS_AMOUNT' ; 
key     ![NET_AMOUNT]: Decimal(15, 2)  @title: 'NET_AMOUNT: NET_AMOUNT' ; 
key     ![TAX_AMOUNT]: Decimal(15, 2)  @title: 'TAX_AMOUNT: TAX_AMOUNT' ; 
}