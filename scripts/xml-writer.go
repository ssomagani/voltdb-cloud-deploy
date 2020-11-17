package main

import (
	"fmt"
	"encoding/xml"
)

type variables map[string]interface{}

type deployment struct {
	cluster struct {
		sitesperhost int
		kfactor int
	}
	dr struct {
		id int
	}
}

func (s variables) MarshalXML(e *xml.Encoder, start xml.StartElement) error {
	
}

func (s deployment) MarshalXML(e *xml.Encoder, start xml.StartElement) error {
	tokens := []xml.Token{start}
	
// 	for key, value := range s {
		
		clusterAttrs := []xml.Attr{
			{ 
			Name:xml.Name{"", "sitesperhost"},
			Value: fmt.Sprintf("%v",s.sitesperhost),
			},
			{ 
			Name:xml.Name{"", "kfactor"},
			Value: fmt.Sprintf("%v",s.kfactor),
			},
		}
		
		t := xml.StartElement { Name: xml.Name{"", "cluster"}, Attr: clusterAttrs}
		tokens = append(tokens, t, xml.EndElement{t.Name})
		
		drAttrs := []xml.Attr {
			{ 
			Name:xml.Name{"", "id"},
			Value: fmt.Sprintf("%v",s.sitesperhost),
			}}
// 	}

	tokens = append(tokens, xml.EndElement{start.Name})
	
	for _, t := range tokens {
        err := e.EncodeToken(t)
        if err != nil {
            return err
        }
    }

	err := e.Flush()
    if err != nil {
        return err
    }

    return nil	
	
}

func main() {
	
// 	m := make(StringMap)
	m := deployment{sitesperhost:8, kfactor:1}
// 	m["sitesperhost"] = 8
// 	m["kfactor"] = 1
	
	fmt.Println(m)
	
	result, err := xml.MarshalIndent(m, "", "  ")
	if err == nil {
		fmt.Println(string(result))
	} else {
		fmt.Println(err)
	}
}
