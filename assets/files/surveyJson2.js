{
  "id": "4744d86d-2d2a-4ecf-81ed-cc02d94c41a1",
  "name": "Survey 1",
  "steps": [
    {
      "id": "fa3f0f53-b5cb-4944-816d-ae45fb64cda5",
      "type": "question",
      "value": {
        "id": "e8b948a6-c8f6-48c7-9bd0-967752622e38",
        "title": "Q1",
        "text": "",
        "description": "",
        "chapter": null,
        "productDetails": "",
        "configuration": {
          "type": "number",
          "options": [
            {
              "id": "65ca9637-d12a-493f-9379-d0f6f73674b1",
              "title": "IDK",
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
                  "parentId": "65ca9637-d12a-493f-9379-d0f6f73674b1"
                },
                {
                  "id": 5,
                  "articleNumber": "E21.3-1004",
                  "name": "BS Contract Entry",
                  "listingPrice": "2490",
                  "status": "active",
                  "salePrice": "2490",
                  "profit": "747",
                  "discount": 30,
                  "quantity": 1,
                  "tax": "19",
                  "parentId": "65ca9637-d12a-493f-9379-d0f6f73674b1"
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
              "id": "90a03275-1f62-410d-b75a-f6a9cee4d37f",
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
                  "quantity": 1,
                  "tax": "19",
                  "parentId": "90a03275-1f62-410d-b75a-f6a9cee4d37f"
                },
                {
                  "id": 3,
                  "articleNumber": "E21.3-1002",
                  "name": "BS Invoice 050 Basis",
                  "listingPrice": "2950",
                  "status": "active",
                  "salePrice": "2950",
                  "profit": "885",
                  "discount": 30,
                  "quantity": 1,
                  "tax": "19",
                  "parentId": "90a03275-1f62-410d-b75a-f6a9cee4d37f"
                }
              ],
              "options": [
                {
                  "option": {
                    "id": "65ca9637-d12a-493f-9379-d0f6f73674b1",
                    "title": "IDK",
                    "value": 30,
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
                        "parentId": "65ca9637-d12a-493f-9379-d0f6f73674b1"
                      },
                      {
                        "id": 5,
                        "articleNumber": "E21.3-1004",
                        "name": "BS Contract Entry",
                        "listingPrice": "2490",
                        "status": "active",
                        "salePrice": "2490",
                        "profit": "747",
                        "discount": 30,
                        "quantity": 1,
                        "tax": "19",
                        "parentId": "65ca9637-d12a-493f-9379-d0f6f73674b1"
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
                },
                {
                                  "option": {
                                    "id": "65ca9637-d12a-493f-9379-d0f6f73674b1",
                                    "title": "IDK",
                                    "value": 30,
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
                                        "parentId": "65ca9637-d12a-493f-9379-d0f6f73674b1"
                                      },
                                      {
                                        "id": 5,
                                        "articleNumber": "E21.3-1004",
                                        "name": "BS Contract Entry",
                                        "listingPrice": "2490",
                                        "status": "active",
                                        "salePrice": "2490",
                                        "profit": "747",
                                        "discount": 30,
                                        "quantity": 1,
                                        "tax": "19",
                                        "parentId": "65ca9637-d12a-493f-9379-d0f6f73674b1"
                                      }
                                    ],
                                    "next": "",
                                    "min": 0,
                                    "max": "100",
                                    "step": "10",
                                    "placeholder": ""
                                  },
                                  "condition": "<",
                                  "operator": "&&",
                                  "value": "50"
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
  "cart": {
    "products": [
      {
        "id": 6,
        "articleNumber": "E21.3-1005",
        "name": "BS Contract Advanced",
        "listingPrice": "4750",
        "status": "active",
        "salePrice": "4275",
        "profit": "1425",
        "discount": 30,
        "quantity": 1,
        "tax": "19",
        "parentId": "65ca9637-d12a-493f-9379-d0f6f73674b1",
        "belongsTo": ["65ca9637-d12a-493f-9379-d0f6f73674b1"]
      },
      {
        "id": 5,
        "articleNumber": "E21.3-1004",
        "name": "BS Contract Entry",
        "listingPrice": "2490",
        "status": "active",
        "salePrice": "2490",
        "profit": "747",
        "discount": 30,
        "quantity": 1,
        "tax": "19",
        "parentId": "65ca9637-d12a-493f-9379-d0f6f73674b1",
        "belongsTo": ["65ca9637-d12a-493f-9379-d0f6f73674b1"]
      }
    ],
    "config": []
  },
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
      "id": "6c44f5eb-0a55-4280-8e7f-5c52d691bc86",
      "type": "row",
      "children": [
        {
          "id": "61ef29f4-c41a-4713-86c7-ae317b176e82",
          "type": "column",
          "children": [],
          "value": 1,
          "contains": "steps"
        },
        {
          "id": "b3362a57-ccaa-44b1-b427-c57f79698aa1",
          "type": "column",
          "children": [
            {
              "id": "68bd9264-6bc1-417a-bad4-b5d5c8d4add4",
              "type": "row",
              "children": [],
              "value": 1,
              "contains": "question"
            },
            {
              "id": "e16b05a4-d36e-4937-8af5-d14c224b0315",
              "type": "row",
              "children": [
                {
                  "id": "18879746-74fc-43c9-bedc-64d29074fdb3",
                  "type": "column",
                  "children": [],
                  "value": 3,
                  "contains": "details"
                },
                {
                  "id": "1d59bb1c-e10d-4da7-9a25-86477309f5ec",
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