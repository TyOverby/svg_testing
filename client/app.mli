module Svg :
  sig
    module N = Virtual_dom_svg.Node
    module A = Virtual_dom_svg.Attr
    val no_attr : Bonsai_web.Vdom.Attr.t
    val ( @ ) :
      Bonsai_web.Vdom.Attr.t ->
      Bonsai_web.Vdom.Attr.t -> Bonsai_web.Vdom.Attr.t
    val group :
      ?attr:Bonsai_web.Vdom.Attr.t ->
      Virtual_dom.Vdom.Node.t list -> Virtual_dom.Vdom.Node.t
    val circle :
      ?attr:Bonsai_web.Vdom.Attr.t ->
      x:float -> y:float -> r:float -> unit -> Virtual_dom.Vdom.Node.t
    val rect :
      ?attr:Bonsai_web.Vdom.Attr.t ->
      x:float ->
      y:float ->
      width:float -> height:float -> unit -> Virtual_dom.Vdom.Node.t
    val line :
      ?attr:Bonsai_web.Vdom.Attr.t ->
      x1:float ->
      y1:float -> x2:float -> y2:float -> unit -> Virtual_dom.Vdom.Node.t
    val polygon :
      ?attr:Bonsai_web.Vdom.Attr.t ->
      (float * float) list -> Virtual_dom.Vdom.Node.t
    val polyline :
      ?attr:Bonsai_web.Vdom.Attr.t ->
      (float * float) list -> Virtual_dom.Vdom.Node.t
    val path :
      ?attr:Bonsai_web.Vdom.Attr.t ->
      A.path_op list -> Virtual_dom.Vdom.Node.t
    val text :
      ?attr:Bonsai_web.Vdom.Attr.t ->
      ?weight:string ->
      ?stroke_color:string ->
      ?fill_color:string ->
      x:float -> y:float -> size:string -> string -> Virtual_dom.Vdom.Node.t
    val svg :
      ?attr:Bonsai_web.Vdom.Attr.t ->
      ?preserve_aspect_ratio:Bonsai_web.Vdom.Attr.t ->
      ?w:string ->
      ?h:string ->
      x_min:float ->
      y_min:float ->
      width:float ->
      height:float -> Virtual_dom.Vdom.Node.t list -> Virtual_dom.Vdom.Node.t
  end
val component : Virtual_dom.Vdom.Node.t Bonsai.Computation.t