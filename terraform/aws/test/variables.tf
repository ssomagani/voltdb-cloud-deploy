// variable deployment      {
// 	type = "map"
// 	default = {
// 		variable kfactor {
// 					default = 0
// 				}
// 		variable cluster {
// 			type = "map"
// 			default = {
// 				variable kfactor {
// 					type = "int"
// 					default = 0
// 				}
// 			}
// 		}
// 	}
// }

variable deployment      {
	type = "map"
	default = {
		variable kfactor { default = "0" }
	}
}

variable kfactor { default = "0" }

variable sitesperhost { default = "4" }