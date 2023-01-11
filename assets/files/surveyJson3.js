{
  "id": "529de9c0-a816-41d1-998e-de382c5af0b1",
  "name": "Survey 1",
  "steps": [
    {
      "id": "141c95d7-d037-452a-98f4-7975f4d39464",
      "type": "question",
      "value": {
        "id": "5b9fcc21-1af5-43b8-bcc5-23c005927030",
        "title": "Q1",
        "text": "FORMULA",
        "description": "description",
        "chapter": null,
        "productDetails": "{\"ops\":[{\"insert\":\"product description\\n\"}]}",
        "configuration": {
          "type": "number",
          "options": [
            {
              "id": "43702475-0440-4878-8ff7-e7ade7c9584b",
              "title": "Option1",
              "value": 0,
              "products": [
                {
                  "id": 6,
                  "articleNumber": "E21.3-1005",
                  "name": "BS Contract Advanced",
                  "listingPrice": "4750",
                  "status": "active",
                  "salePrice": "4750",
                  "profit": "1425",
                  "discount": 30,
                  "quantity": 1,
                  "tax": "19",
                  "parentId": "43702475-0440-4878-8ff7-e7ade7c9584b"
                }
              ],
              "next": "",
              "min": 0,
              "max": "100",
              "step": "10",
              "placeholder": ""
            }
          ],
          "conditionsForProductSelection": [
            {
              "id": "2651b088-ca9d-4f14-86ea-417c557025f6",
              "discount": "10",
              "products": [
                {
                  "id": 6,
                  "articleNumber": "E21.3-1005",
                  "name": "BS Contract Advanced",
                  "listingPrice": "4750",
                  "status": "active",
                  "salePrice": "4750",
                  "profit": "1425",
                  "discount": 30,
                  "quantity": "=10+$option1",
                  "tax": "19",
                  "parentId": "2651b088-ca9d-4f14-86ea-417c557025f6"
                }
              ],
              "options": [
                {
                  "option": {
                    "id": "43702475-0440-4878-8ff7-e7ade7c9584b",
                    "title": "Option1",
                    "value": 0,
                    "products": [
                      {
                        "id": 6,
                        "articleNumber": "E21.3-1005",
                        "name": "BS Contract Advanced",
                        "listingPrice": "4750",
                        "status": "active",
                        "salePrice": "4750",
                        "profit": "1425",
                        "discount": 30,
                        "quantity": 1,
                        "tax": "19",
                        "parentId": "43702475-0440-4878-8ff7-e7ade7c9584b"
                      }
                    ],
                    "next": "",
                    "min": 0,
                    "max": "100",
                    "step": "10",
                    "placeholder": ""
                  },
                  "condition": "==",
                  "operator": "if",
                  "value": "20"
                }
              ],
              "isSatisfied": false,
              "next": ""
            }
          ]
        },
        "next": "",
        "back": ""
      }
    }
  ],
  "cart": { "products": [], "config": [] },
  "stylesConfiguration": {
    "stepsCardBgColor": "#ffffff",
    "stepsCardTextColor": "#000000",
    "stepsCardHeaderBgColor": "#fafafa",
    "stepsCardHeaderTextColor": "#000000",
    "questionDetailsCardBgColor": "#ffffff",
    "questionDetailsCardTextColor": "#000000",
    "cartCardBgColor": "#ffffff",
    "cartCardTextColor": "#000000",
    "cartCardHeaderBgColor": "#fafafa",
    "cartCardHeaderTextColor": "#000000",
    "productDetailsCardBgColor": "#ffffff",
    "productDetailsCardTextColor": "#000000",
    "productDetailsHeaderBgColor": "#fafafa",
    "productDetailsHeaderTextColor": "#000000",
    "layout": {
      "id": "caee88fc-ef0f-4018-a535-dc8fdb4d879b",
      "type": "row",
      "children": [
        {
          "id": "3b16054d-6ab0-43ca-b63c-d5ab39cce7d9",
          "type": "column",
          "children": [],
          "value": 1,
          "contains": "steps"
        },
        {
          "id": "0feacab0-cec2-44cc-a8f5-5bdb4cbbbf38",
          "type": "column",
          "children": [
            {
              "id": "0bc42cf9-bccd-48a3-96f9-e1cf767006f6",
              "type": "row",
              "children": [],
              "value": 1,
              "contains": "question"
            },
            {
              "id": "3a1e4c7d-7846-44e6-a4a2-617d0ba5557e",
              "type": "row",
              "children": [
                {
                  "id": "a2c653f8-be98-47ad-8b59-625fe2d0bd86",
                  "type": "column",
                  "children": [],
                  "value": 3,
                  "contains": "details"
                },
                {
                  "id": "1b1200c6-b8dc-4284-af44-3aeb637cc8e3",
                  "type": "column",
                  "children": [],
                  "value": 2,
                  "contains": "cart"
                }
              ],
              "value": 2,
              "contains": null
            }
          ],
          "value": 3,
          "contains": null
        }
      ],
      "value": 1,
      "contains": null
    }
  }
}