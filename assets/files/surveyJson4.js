{
  "id": "18606aa8-7eaa-3d03-0162-fa30f38a2339",
  "name": "Survey 1",
  "steps": [
    {
        "id": "c238b74a-61a5-454d-9129-7c7d43047fd7",
        "type": "question",
        "value": {
          "id": 1,
          "title": "Q1",
          "text": "",
          "description": "",
          "chapter": null,
          "chapterId": null,
          "surveyId": "186172b3-1b7b-bda8-0129-2ace1de65c2a",
          "productDetails": "",
          "configuration": {
            "type": "single",
            "options": [
              {
                "id": "4a1a3aee93994c059925171c0ff17404",
                "uuid": "4a1a3aee93994c059925171c0ff17404",
                "title": "Option1",
                "value": "",
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
                    "parentId": "4a1a3aee93994c059925171c0ff17404"
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
                    "parentId": "4a1a3aee93994c059925171c0ff17404"
                  }
                ],
                "next": "",
                "min": 0,
                "max": 0,
                "step": 0,
                "placeholder": ""
              },
              {
                "id": "4f3edd214d384dad827a71ac7cd59d10",
                "uuid": "4f3edd214d384dad827a71ac7cd59d10",
                "title": "Option2",
                "value": "",
                "products": [
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
                    "parentId": "4f3edd214d384dad827a71ac7cd59d10"
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
                    "parentId": "4f3edd214d384dad827a71ac7cd59d10"
                  }
                ],
                "next": "",
                "min": 0,
                "max": 0,
                "step": 0,
                "placeholder": ""
              }
            ],
            "conditionsForProductSelection": []
          },
          "next": "",
          "back": "",
          "order": -1
        }
      },
    {
      "id": "bb434b64-5e7b-4dc8-9183-39a435401041",
      "type": "question",
      "value": {
        "id": 1,
        "title": "Q1",
        "text": "jknkn",
        "order": -1,
        "description": "kjnkjnkjn",
        "productDetails": "{\"ops\":[{\"insert\":\"kjknkjnj\\n\"}]}",
        "chapterId": null,
        "chapterName": "",
        "configuration": {
          "type": "number",
          "options": [
            {
              "id": 1,
              "uuid": "35078bab3acb4504824f587bbac9e7ad",
              "title": "Option1",
              "min": 0,
              "max": 100,
              "step": 10,
              "next": "",
              "placeholder": "",
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
                  "quantity": "1",
                  "tax": "19"
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
                  "quantity": "1",
                  "tax": "19"
                }
              ],
              "value": ""
            }
          ],
          "conditionsForProductSelection": []
        }
      }
    },
    {
      "id": "cbc0a6fa-8ed2-45cb-b7b6-b54f67fc157a",
      "type": "question",
      "value": {
        "id": 2,
        "title": "Q2",
        "text": "jknkjn",
        "order": 4611686018427388000,
        "description": "lnjknjmklmlk",
        "productDetails": "{\"ops\":[{\"insert\":\"nkjnkjnkjnkjnjk\\n\"}]}",
        "chapterId": null,
        "chapterName": "",
        "configuration": {
          "type": "slider",
          "options": [
            {
              "id": 2,
              "uuid": "8fe07f90b3d54634b9783f5a1498c25d",
              "title": "Option1",
              "min": 0,
              "max": "100",
              "step": "10",
              "next": "",
              "placeholder": "",
              "products": [],
              "value": ""
            }
          ],
          "conditionsForProductSelection": [
            {
              "id": 1,
              "discount": "10",
              "next": "",
              "options": [
                {
                  "id": 1,
                  "condition": "==",
                  "option": {
                    "id": 2,
                    "uuid": "8fe07f90b3d54634b9783f5a1498c25d",
                    "title": "Option1",
                    "min": 0,
                    "max": "100",
                    "step": "10",
                    "next": "",
                    "placeholder": "",
                    "products": [],
                    "value": ""
                  },
                  "operator": "if",
                  "value": "20"
                }
              ],
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
                  "tax": "19"
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
                  "tax": "19"
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
                  "tax": "19"
                }
              ]
            }
          ]
        }
      }
    },
    {
          "id": "05c66adf-33be-4094-849c-a9a11f064288",
          "type": "question",
          "value": {
            "id": 2,
            "title": "Q2",
            "text": "",
            "description": "",
            "chapter": null,
            "chapterId": null,
            "surveyId": "186172b3-1b7b-bda8-0129-2ace1de65c2a",
            "productDetails": "",
            "configuration": {
              "type": "text",
              "options": [
                {
                  "id": "76385eaf59bd42e7b940f27065e77dad",
                  "uuid": "76385eaf59bd42e7b940f27065e77dad",
                  "title": "Name",
                  "value": "",
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
                      "parentId": "76385eaf59bd42e7b940f27065e77dad"
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
                      "parentId": "76385eaf59bd42e7b940f27065e77dad"
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
                      "parentId": "76385eaf59bd42e7b940f27065e77dad"
                    }
                  ],
                  "next": "",
                  "min": 0,
                  "max": 0,
                  "step": 0,
                  "placeholder": "enter your name"
                }
              ],
              "conditionsForProductSelection": [
                {
                  "id": "0b699951e1d04b528eba0c94c8137b56",
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
                      "parentId": "0b699951e1d04b528eba0c94c8137b56"
                    }
                  ],
                  "options": [
                    {
                      "option": {
                        "id": "76385eaf59bd42e7b940f27065e77dad",
                        "uuid": "76385eaf59bd42e7b940f27065e77dad",
                        "title": "Name",
                        "value": "",
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
                            "parentId": "76385eaf59bd42e7b940f27065e77dad"
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
                            "parentId": "76385eaf59bd42e7b940f27065e77dad"
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
                            "parentId": "76385eaf59bd42e7b940f27065e77dad"
                          }
                        ],
                        "next": "",
                        "min": 0,
                        "max": 0,
                        "step": 0,
                        "placeholder": "enter your name"
                      },
                      "condition": "contains",
                      "operator": "if",
                      "value": "talha"
                    }
                  ],
                  "isSatisfied": false,
                  "next": ""
                }
              ]
            },
            "upperQuestionOrder": -1,
            "next": "",
            "back": "",
            "order": 4611686018427388000
          }
        },
    {
              "id": "44a7e485-e3d6-40c0-8cec-335267238dbf",
              "type": "question",
              "value": {
                "id": 1,
                "title": "Q1",
                "text": "kn",
                "description": "kjnkjnkjn",
                "chapter": null,
                "chapterId": null,
                "surveyId": "18625af6-aa7d-9487-0157-d8ece6c1e7a3",
                "productDetails": "{\"ops\":[{\"insert\":\"hjkbkjnkjnkj\\n\"}]}",
                "configuration": {
                  "type": "multi",
                  "options": [
                    {
                      "id": "c60cd668c1d04465b79f10025b6c59b0",
                      "uuid": "c60cd668c1d04465b79f10025b6c59b0",
                      "title": "Option1",
                      "value": "",
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
                          "parentId": "c60cd668c1d04465b79f10025b6c59b0"
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
                          "parentId": "c60cd668c1d04465b79f10025b6c59b0"
                        }
                      ],
                      "next": "",
                      "min": 0,
                      "max": 0,
                      "step": 0,
                      "placeholder": ""
                    },
                    {
                      "id": "8bb27d3f9e6b41219ec8512be41adefc",
                      "uuid": "8bb27d3f9e6b41219ec8512be41adefc",
                      "title": "Option2",
                      "value": "",
                      "products": [],
                      "next": "",
                      "min": 0,
                      "max": 0,
                      "step": 0,
                      "placeholder": ""
                    }
                  ],
                  "conditionsForProductSelection": [
                    {
                      "id": "b698b20ae795498b88c8c4e2e7803ee7",
                      "discount": "10",
                      "products": [
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
                          "parentId": "b698b20ae795498b88c8c4e2e7803ee7"
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
                          "parentId": "b698b20ae795498b88c8c4e2e7803ee7"
                        },
                        {
                          "id": 4,
                          "articleNumber": "E21.3-1003",
                          "name": "BS Invoice 200 Plus",
                          "listingPrice": "4950",
                          "status": "active",
                          "salePrice": "4950",
                          "profit": "1485",
                          "discount": 30,
                          "quantity": 1,
                          "tax": "19",
                          "parentId": "b698b20ae795498b88c8c4e2e7803ee7"
                        }
                      ],
                      "options": [
                        {
                          "option": {
                            "id": "8bb27d3f9e6b41219ec8512be41adefc",
                            "uuid": "8bb27d3f9e6b41219ec8512be41adefc",
                            "title": "Option2",
                            "value": "",
                            "products": [],
                            "next": "",
                            "min": 0,
                            "max": 0,
                            "step": 0,
                            "placeholder": ""
                          },
                          "condition": "checked",
                          "operator": "if"
                        }
                      ],
                      "isSatisfied": false,
                      "next": ""
                    }
                  ]
                },
                "next": "",
                "back": "",
                "order": -1
              }
            },
    {
      "id": "567f5166-5c2b-4ede-bb84-805b4840ecef",
      "type": "chapter",
      "value": {
        "id": 1,
        "title": "Chapter1",
        "questions": [
          {
                  "id": "05c66adf-33be-4094-849c-a9a11f064288",
                  "type": "question",
                  "value": {
                    "id": 2,
                    "title": "Q2",
                    "text": "",
                    "description": "",
                    "chapter": null,
                    "chapterId": null,
                    "surveyId": "186172b3-1b7b-bda8-0129-2ace1de65c2a",
                    "productDetails": "",
                    "configuration": {
                      "type": "text",
                      "options": [
                        {
                          "id": "76385eaf59bd42e7b940f27065e77dad",
                          "uuid": "76385eaf59bd42e7b940f27065e77dad",
                          "title": "Name",
                          "value": "",
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
                              "parentId": "76385eaf59bd42e7b940f27065e77dad"
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
                              "parentId": "76385eaf59bd42e7b940f27065e77dad"
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
                              "parentId": "76385eaf59bd42e7b940f27065e77dad"
                            }
                          ],
                          "next": "",
                          "min": 0,
                          "max": 0,
                          "step": 0,
                          "placeholder": "enter your name"
                        }
                      ],
                      "conditionsForProductSelection": [
                        {
                          "id": "0b699951e1d04b528eba0c94c8137b56",
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
                              "parentId": "0b699951e1d04b528eba0c94c8137b56"
                            }
                          ],
                          "options": [
                            {
                              "option": {
                                "id": "76385eaf59bd42e7b940f27065e77dad",
                                "uuid": "76385eaf59bd42e7b940f27065e77dad",
                                "title": "Name",
                                "value": "",
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
                                    "parentId": "76385eaf59bd42e7b940f27065e77dad"
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
                                    "parentId": "76385eaf59bd42e7b940f27065e77dad"
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
                                    "parentId": "76385eaf59bd42e7b940f27065e77dad"
                                  }
                                ],
                                "next": "",
                                "min": 0,
                                "max": 0,
                                "step": 0,
                                "placeholder": "enter your name"
                              },
                              "condition": "contains",
                              "operator": "if",
                              "value": "talha"
                            }
                          ],
                          "isSatisfied": false,
                          "next": ""
                        }
                      ]
                    },
                    "upperQuestionOrder": -1,
                    "next": "",
                    "back": "",
                    "order": 4611686018427388000
                  }
                },
          {
        "id": "c238b74a-61a5-454d-9129-7c7d43047fd7",
        "type": "question",
        "value": {
          "id": 1,
          "title": "Q1",
          "text": "",
          "description": "",
          "chapter": null,
          "chapterId": null,
          "surveyId": "186172b3-1b7b-bda8-0129-2ace1de65c2a",
          "productDetails": "",
          "configuration": {
            "type": "single",
            "options": [
              {
                "id": "4a1a3aee93994c059925171c0ff17404",
                "uuid": "4a1a3aee93994c059925171c0ff17404",
                "title": "Option1",
                "value": "",
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
                    "parentId": "4a1a3aee93994c059925171c0ff17404"
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
                    "parentId": "4a1a3aee93994c059925171c0ff17404"
                  }
                ],
                "next": "",
                "min": 0,
                "max": 0,
                "step": 0,
                "placeholder": ""
              },
              {
                "id": "4f3edd214d384dad827a71ac7cd59d10",
                "uuid": "4f3edd214d384dad827a71ac7cd59d10",
                "title": "Option2",
                "value": "",
                "products": [
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
                    "parentId": "4f3edd214d384dad827a71ac7cd59d10"
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
                    "parentId": "4f3edd214d384dad827a71ac7cd59d10"
                  }
                ],
                "next": "",
                "min": 0,
                "max": 0,
                "step": 0,
                "placeholder": ""
              }
            ],
            "conditionsForProductSelection": []
          },
          "next": "",
          "back": "",
          "order": -1
        }
      },
          {
            "id": "105e5597-fc10-42bb-a14e-df37dc0b1275",
            "type": "question",
            "value": {
              "id": 3,
              "title": "Q3",
              "text": "jknkjnk",
              "order": -1,
              "description": "nkjnkjnknkj",
              "productDetails": "{\"ops\":[{\"insert\":\"jknkjnjk\\n\"}]}",
              "chapterId": 1,
              "chapterName": "Chapter1",
              "configuration": {
                "type": "number",
                "options": [
                  {
                    "id": 3,
                    "uuid": "4679a030171e4f27b6d42af3f1520e91",
                    "title": "Option1",
                    "min": 0,
                    "max": 100,
                    "step": 10,
                    "next": "",
                    "placeholder": "",
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
                                      "quantity": "=10+$4679a030171e4f27b6d42af3f1520e91",
                                      "tax": "19"
                                    },
                      {
                        "id": 4,
                        "articleNumber": "E21.3-1003",
                        "name": "BS Invoice 200 Plus",
                        "listingPrice": "4950",
                        "status": "active",
                        "salePrice": "4950",
                        "profit": "1485",
                        "discount": 30,
                        "quantity": "=10+$4679a030171e4f27b6d42af3f1520e91",
                        "tax": "19"
                      }
                    ],
                    "value": ""
                  }
                ],
                "conditionsForProductSelection": []
              }
            }
          },
          {
            "id": "6372f0fe-fa16-4b40-9ba1-0fea7dc24c60",
            "type": "question",
            "value": {
              "id": 4,
              "title": "Q4",
              "text": "jknk`j",
              "order": -1,
              "description": "jnkjnkjnkjnkj",
              "productDetails": "{\"ops\":[{\"insert\":\"jknkjn\\n\"}]}",
              "chapterId": 1,
              "chapterName": "Chapter1",
              "configuration": {
                "type": "slider",
                "options": [
                  {
                    "id": 4,
                    "uuid": "f3fa921ba64148e794d8f96f28946d49",
                    "title": "Option1",
                    "min": 0,
                    "max": 100,
                    "step": 10,
                    "next": "",
                    "placeholder": "",
                    "products": [
                      {
                        "id": 3,
                        "articleNumber": "E21.3-1002",
                        "name": "BS Invoice 050 Basis",
                        "listingPrice": "2950",
                        "status": "active",
                        "salePrice": "2950",
                        "profit": "885",
                        "discount": 30,
                        "quantity": "[{\"type\":\"single\",\"operator\":null,\"value\":\"5\",\"parenthesis\":[{\"type\":\"block\",\"operator\":\"+\",\"value\":\"Option1\",\"parenthesis\":[],\"id\":\"f3fa921ba64148e794d8f96f28946d49\"}]}]",
                        "tax": "19"
                      }
                    ],
                    "value": ""
                  }
                ],
                "conditionsForProductSelection": []
              }
            }
          }
        ]
      }
    }
  ],
  "cart": { "products": [], "config": [], "addProductsManually": false },
  "stylesConfiguration": {
    "steps": {
      "cardBgColor": "#ffffff",
      "cardTextColor": "#000000",
      "cardHeaderBgColor": "#fafafa",
      "cardHeaderTextColor": "#000000"
    },
    "questionDetails": { "cardBgColor": "#ffffff", "cardTextColor": "#000000" },
    "cart": {
      "cardBgColor": "#ffffff",
      "cardTextColor": "#000000",
      "cardHeaderBgColor": "#fafafa",
      "cardHeaderTextColor": "#000000"
    },
    "productDetails": {
      "cardBgColor": "#ffffff",
      "cardTextColor": "#000000",
      "cardHeaderBgColor": "#fafafa",
      "cardHeaderTextColor": "#000000"
    }
  }
}