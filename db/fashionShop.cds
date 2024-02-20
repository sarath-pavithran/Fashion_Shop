namespace app.fashionShop;
using { Currency } from '@sap/cds/common';
type Flag : String(1);
entity Sections {
  key id : UUID @(title : 'Section ID');
    name : String(16) @(title : 'Section Name');
    description : String(64) @(title : 'Section Desc');
}

entity Fashion_types {
    key id : UUID @(title : 'Fashion Type ID');
      section : Association to Sections @(title : 'Section ID');
      typename : String(16) @(title : 'Fashion Type name');
      description : String(64) @(title : 'Fashion Type Desc');
}

entity Fashion_Items {
  key id : UUID @(title : 'Fashion Item Id');
    FashionType : Association to Fashion_types @(title : 'Fashion Type ID');
    itemname : String(16) @(title : 'Fashion Item Name');
    brand : String(16) @(title : 'Fashion Brand');
    size : String(8) @(title : 'Size');
    material : String(16) @(title : 'Material');
    price : String(10) @(title : 'Price');
    currency : Currency @(title : 'Currency');
    isAvailable : Flag ;
}

//View Creation for Fashion Shop
view YC_FashionShop as select from Fashion_Items as fItem {
  fItem.FashionType.section.id as sectionId,
  fItem.FashionType.section.name as sectionName,
  fItem.FashionType.section.description as sectionDesc,
  fItem.FashionType.id as fashionTypeId,
  fItem.FashionType.typename as fashionTypeName,
  fItem.FashionType.description as fashionTypeDesc,
  fItem.id as fashionItemId,
  fItem.itemname as fashionItemName,
  fItem.brand as brand,
  fItem.size as size,
  fItem.material as material,
  fItem.price as price,
  fItem.currency as currency,
  // fItem.isAvailable as isAvailable,
  concat( fItem.brand, concat( ' ', fItem.itemname ) ) as itemDetails : String(32),
  case
    when  fItem.price >= 500 then 'Premium'
    when fItem.price >= 100 and fItem.price < 500 then 'Mid-Range'
    else 'Low-Range'
  end as priceRange : String(10)

} where fItem.isAvailable = 'X';

view YC_FashionType as select from Fashion_types as fType
{
  fType.id as fashionTypeID,
  fType.typename as fashionTypeName,
  fType.section.name as sectionName
}
