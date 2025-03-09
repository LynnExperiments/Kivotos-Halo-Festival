using Godot;
using System;

public class player1 : KinematicBody2D
{
    const float GRAVITY = 9.81f;
    const float MASS = .8f;
    const float SPEED = 200f;

    private Vector2 move = Vector2.Zero;
    private Vector2 moveDir = -1; 

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        
    }

    public override void _PhysicsProcess(float delta)
    {
        applyGravity(delta);
        handleMove(delta);
        MoveAndSlide(move);
    }

    private void applyGravity(float delta)
    {
        move.y += MASS*GRAVITY;
    }

    private void handleMove(float delta)
    {
        move.x = moveDir + SPEED;
    }

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}
