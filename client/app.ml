open! Core
open! Bonsai_web
open Bonsai.Let_syntax

module Svg = struct
  module N = Virtual_dom_svg.Node
  module A = Virtual_dom_svg.Attr

  let no_attr = Vdom.Attr.empty
  let ( @ ) = Vdom.Attr.( @ )
  let group ?attr children = N.g ?attr children

  let circle ?(attr = no_attr) ~x ~y ~r () =
    N.circle ~attr:(A.cx x @ A.cy y @ A.r r @ attr) []
  ;;

  let rect ?(attr = no_attr) ~x ~y ~width ~height () =
    N.rect ~attr:(A.x x @ A.y y @ A.width width @ A.height height @ attr) []
  ;;

  let line ?(attr = no_attr) ~x1 ~y1 ~x2 ~y2 () =
    N.line ~attr:(A.x1 x1 @ A.x2 x2 @ A.y1 y1 @ A.y2 y2 @ attr) []
  ;;

  let polygon ?(attr = no_attr) points = N.polygon ~attr:(A.points points @ attr) []
  let polyline ?(attr = no_attr) points = N.polyline ~attr:(A.points points @ attr) []
  let path ?(attr = no_attr) commands = N.path ~attr:(A.d commands @ attr) []

  let text ?(attr = no_attr) ?weight ?stroke_color ?fill_color ~x ~y ~size text =
    let style =
      Vdom.Attr.style
        Css_gen.(
          create ~field:"font-size" ~value:size
          @> Option.value_map
               weight
               ~f:(fun w -> Css_gen.create ~field:"font-weight" ~value:w)
               ~default:Css_gen.empty
          @> Option.value_map
               fill_color
               ~f:(fun w -> Css_gen.create ~field:"fill" ~value:w)
               ~default:Css_gen.empty
          @> Option.value_map
               stroke_color
               ~f:(fun w -> Css_gen.create ~field:"stroke" ~value:w)
               ~default:Css_gen.empty)
    in
    N.text ~attr:(A.x x @ A.y y @ style @ attr) [ Vdom.Node.text text ]
  ;;

  let svg
      ?(attr = no_attr)
      ?(preserve_aspect_ratio =
        A.preserve_aspect_ratio ~meet_or_slice:`Slice ~align:A.None ())
      ?(w = "100%")
      ?(h = "100%")
      ~x_min
      ~y_min
      ~width
      ~height
      nodes
    =
    let style =
      Vdom.Attr.style
        Css_gen.(create ~field:"width" ~value:w @> create ~field:"height" ~value:h)
    in
    let viewbox = A.viewbox ~min_x:x_min ~min_y:y_min ~width ~height in
    N.svg ~attr:(preserve_aspect_ratio @ viewbox @ style @ attr) nodes
  ;;
end

module Float_star_float = struct
  type t = float * float [@@deriving equal, sexp]
end

let node ~x ~y ~on_down ~on_up ~on_move =
  let ( @ ) = Vdom.Attr.( @ ) in
  Svg.svg
    ~attr:
      (Vdom.Attr.on_mousedown on_down
      @ Vdom.Attr.on_mouseup on_up
      @ Vdom.Attr.on_mousemove on_move)
    ~x_min:x
    ~y_min:y
    ~width:200.0
    ~height:200.0
    [ Svg.circle ~x:0.0 ~y:0.0 ~r:10.0 ()
    ; Svg.text ~x:0.0 ~y:0.0 ~size:"20px" ~fill_color:"red" "hello  world"
    ]
;;

let component =
  let%sub xy_state =
    Bonsai.state [%here] (module Float_star_float) ~default_model:(0.0, 0.0)
  in
  let%sub mouse_state = Bonsai.state [%here] (module Bool) ~default_model:false in
  return
    (let%map (x, y), set_xy = xy_state
     and mouse_down, set_mouse_down = mouse_state in
     let on_move evt =
       let evt = Obj.magic evt in
       if mouse_down
       then set_xy (x -. evt##.movementX, y -. evt##.movementY)
       else Vdom.Effect.Ignore
     in
     node
       ~x
       ~y
       ~on_up:(fun _ -> set_mouse_down false)
       ~on_down:(fun _ -> set_mouse_down true)
       ~on_move)
;;
