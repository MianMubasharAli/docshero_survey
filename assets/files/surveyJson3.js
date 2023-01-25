{
  "id": "f6d128b3-81b9-4723-a325-991885f30e34",
  "name": "Survey 1",
  "steps": [
    {
      "id": "b19b86bf-f0a9-42db-9ffe-6b7325a9a34b",
      "type": "question",
      "value": {
        "id": 13,
        "title": "Q1",
        "text": "",
        "description": "",
        "chapter": null,
        "chapterId": null,
        "surveyId": null,
        "productDetails": "",
        "configuration": {
          "type": "number",
          "options": [
            {
              "id": "6fd9c19c-f447-452f-8839-95c9089fdab7",
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
                  "quantity": "=5+$option1",
                  "tax": "19",
                  "parentId": "6fd9c19c-f447-452f-8839-95c9089fdab7"
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
              "id": "d4aa51b8-1ee7-4e2d-bc2e-3118abc9ad41",
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
                  "quantity": "[{\"type\":\"single\",\"operator\":null,\"value\":\"10\",\"parenthesis\":[{\"type\":\"block\",\"operator\":\"+\",\"value\":\"Option1\",\"parenthesis\":[],\"id\":\"6fd9c19c-f447-452f-8839-95c9089fdab7\"}]}]",
                  "tax": "19",
                  "parentId": "d4aa51b8-1ee7-4e2d-bc2e-3118abc9ad41"
                }
              ],
              "options": [
                {
                  "option": {
                    "id": "6fd9c19c-f447-452f-8839-95c9089fdab7",
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
                        "quantity": "=5+$option1",
                        "tax": "19",
                        "parentId": "6fd9c19c-f447-452f-8839-95c9089fdab7"
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
      "id": "93f845f1-be5c-4e73-849e-9ef286fb362f",
      "type": "row",
      "children": [
        {
          "id": "a3f0d7f3-91bf-4e63-8a01-546838313cca",
          "type": "column",
          "children": [],
          "value": 1,
          "contains": "steps"
        },
        {
          "id": "e6a85160-12f6-4408-9c99-4ed10e15dd34",
          "type": "column",
          "children": [
            {
              "id": "f6e9aa13-7043-4e6b-8ed6-27a9dafa3634",
              "type": "row",
              "children": [],
              "value": 1,
              "contains": "question"
            },
            {
              "id": "4cd318b8-4d0b-494f-87b6-54afdf9da1c8",
              "type": "row",
              "children": [
                {
                  "id": "b87c3d3d-f934-4b0b-b9de-d37f857e02e4",
                  "type": "column",
                  "children": [],
                  "value": 3,
                  "contains": "details"
                },
                {
                  "id": "e277c24d-cb49-4f26-a62a-a5e75f73d2e3",
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