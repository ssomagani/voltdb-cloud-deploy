package main

import (
	"fmt"
	"encoding/xml"
	"io/ioutil"
	"github.com/hashicorp/hcl"
	"reflect"
// 	"github.com/mitchellh/mapstructure"
// 	"github.com/hashicorp/hcl/json"
)

type variables map[string]interface{}

// type Deployment struct {
// 	Cluster struct {
// 		Sitesperhost struct {
// 			Default int `hcl:default`
// 		}
// 		Kfactor struct {
// 			Default int
// 		}
// 	}
// 	DR struct {
// 		Id struct {
// 			Default int
// 		}
// 	}
// }

func (s variables) MarshalXML(e *xml.Encoder, start xml.StartElement) error {
	tokens := []xml.Token{start}
	
	for key, value := range s {
		fmt.Println("key: " + key)
		fmt.Printf("%v is a  %v\n", value, reflect.TypeOf(value))
		fmt.Printf("%v is a map? %v\n", value, reflect.ValueOf(value).Kind())
		switch v := value.(type) {
			case string:
				fmt.Println("String " + value.(string))
			case []interface {}:
				fmt.Println("generic interface")
// 			case []interface:
// 				fmt.Println("slice")
			default:
				fmt.Println("Unable to assert type %T", v)
		}
		
// 		t := xml.StartElement{Name: xml.Name{"", key}}
// 		tokens = append(tokens, t, xml.CharData(value), xml.EndElement{t.Name})
	}
		
	tokens = append(tokens, xml.EndElement{start.Name})

    for _, t := range tokens {
        err := e.EncodeToken(t)
        if err != nil {
            return err
        }
    }

    // flush to ensure tokens are written
    err := e.Flush()
    if err != nil {
        return err
    }

    return nil
}

func main() {
	input, err := ioutil.ReadFile("../scrap/deployment.tf")
	
	if err != nil {
        fmt.Print(err)
    }

	var mapResult variables
	
	err = hcl.Unmarshal(input, &mapResult)
	
	if err != nil {
		fmt.Println(err)
	}
	
	fmt.Println(mapResult)
	
	result, err := xml.MarshalIndent(mapResult, "", "  ")
	if err == nil {
		fmt.Println(string(result))
	} else {
		fmt.Println(err)
	}
	
// 	var result Deployment
// 	
// 	err_2 := mapstructure.Decode(mapResult, &result)
// 	if err_2 != nil {
//     	panic(err_2)
// 	}
// 
// 	fmt.Printf("%#v", result)
// 	fmt.Println()
	
// 	xml, err := xml.Marshal(v)
// 	if err != nil {
// 		fmt.Print(err)
// 	}
// 	
// 	fmt.Println(string(xml))
	
// 	f, diags := parser.ParseHCLFile("../scrap/test.tf")
}