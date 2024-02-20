using app.fashionShop from '../db/fashionShop';

service FashionShop_Service {
  entity Sections        as projection on fashionShop.Sections;

  @cds.redirection.target: true
  entity Fashion_Types   as projection on fashionShop.Fashion_types;

  entity Fashion_Items   as projection on fashionShop.Fashion_Items;
  entity srv_FashionShop as projection on fashionShop.YC_FashionShop;
  entity F4_FashionType  as projection on fashionShop.YC_FashionType;

}

//Creating Fiori Annotation
@odata.draft.enabled
annotate fashionShop.Fashion_Items with @(UI: {
  HeaderInfo             : {
    $Type         : 'UI.HeaderInfoType',
    TypeName      : 'Online Fashion Shop',
    TypeNamePlural: 'Online Fashion Shop',
    Title         : {Value: itemname},
    Description   : {Value: 'Online Fashion Shop'}
  },
  SelectionFields        : [
    FashionType_id,
    itemname,
    brand,
    size,
    price
  ],
  LineItem               : [
    {Value: FashionType.section.name},
    {Value: FashionType.typename},
    {Value: itemname},
    {Value: brand},
    {Value: size},
    {Value: price},
    {Value: currency_code}
  ],
  Facets                 : [
    {
      $Type : 'UI.CollectionFacet',
      ID    : '1',
      Label : 'Fashion Type & Section',
      Facets: [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#TypeSection',

      }]
    },
    {
      $Type : 'UI.CollectionFacet',
      ID    : '2',
      Label : 'Fashion Item',
      Facets: [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#FItem',

      }, ],
    }
  ],
  FieldGroup #TypeSection: {Data: [
    {Value: FashionType_id},
    {
      Value                  : FashionType.typename,
      ![@Common.FieldControl]: #ReadOnly
    },
    {
      Value                  : FashionType.description,
      ![@Common.FieldControl]: #ReadOnly
    },
    {
      Value                  : FashionType.section.id,
      ![@Common.FieldControl]: #ReadOnly
    },
    {
      Value                  : FashionType.section.name,
      ![@Common.FieldControl]: #ReadOnly
    },
  ], },
  FieldGroup #FItem      : {Data: [
    {Value: id},
    {Value: itemname},
    {Value: brand},
    {Value: material},
    {Value: size},
    {Value: price},
    {Value: currency_code},
    {Value: isAvailable},
  ], },

});

annotate fashionShop.Fashion_Items with {
  FashionType @(
    title         : 'Fashion Type',
    sap.value.list: 'fixed-values',
    Common        : {
      ValueListWithFixedValues,
      ValueList: {
        CollectionPath: 'F4_FashionType',
        Parameters    : [
          {
            $Type            : 'Common.ValueListParameterInOut',
            ValueListProperty: 'fashionTypeID',
            LocalDataProperty: FashionType_id
          },
          {
            $Type            : 'Common.ValueListParameterDisplayOnly',
            ValueListProperty: 'sectionName'
          },
          {
            $Type            : 'Common.ValueListParameterDisplayOnly',
            ValueListProperty: 'fashionTypeName'
          }


        ]
      }
    }
  )

};
