module SimpleBoids


struct BoidState
    positions::Vector{Vector{Float64}}
    orientations::Vector{Vector{Float64}}
end

function norm(v1,v2)
    return sqrt(sum(x->x^2,v1-v2))
end

function ruleOrientations!(orientations::Vector{Vector{Float64}},positions::Vector{Vector{Float64}},paramMaxRad::Float64,paramVelWeight::Float64)
    for i in eachindex(orientations)
        temp=[0.,0.]
        for j in eachindex(orientations)
            if i==j
                continue
            end
            if norm(positions[i],positions[j])>paramMaxRad
                continue
            end
            temp.+=orientations[j]
        end
        if temp[1]^2+temp[2]^2==0.
            continue
        end
        orientations[i][1]+=(temp[1]/sqrt(temp[1]^2+temp[2]^2)-orientations[i][1])*paramVelWeight
        orientations[i][2]+=(temp[2]/sqrt(temp[1]^2+temp[2]^2)-orientations[i][2])*paramVelWeight
        orientations[i]/=sqrt(orientations[i][1]^2+orientations[i][2]^2)
    end
end

function rulePosition!(orientations::Vector{Vector{Float64}},positions::Vector{Vector{Float64}},paramMaxRad::Float64,paramMinRad::Float64,paramPosWeight::Float64,paramRepWeight::Float64)
    for i in eachindex(orientations)
        temp=[0.,0.]
        N=0
        temprepulse=[0.,0.]
        Nr=0
        for j in eachindex(positions)
            if i==j
                continue
            end
            if norm(positions[i],positions[j])>paramMaxRad
                continue
            end
            if norm(positions[i],positions[j])<paramMinRad
                temprepulse.+=positions[j]
                Nr+=1
                continue
            end
            temp.+=positions[j]
            N+=1
        end
        if temp[1]^2+temp[2]^2!=0.
            temp/=N
            temp.-=positions[i]
            orientations[i][1]+=temp[1]/sqrt(temp[1]^2+temp[2]^2)*paramPosWeight
            orientations[i][2]+=temp[2]/sqrt(temp[1]^2+temp[2]^2)*paramPosWeight
            orientations[i]/=sqrt(orientations[i][1]^2+orientations[i][2]^2)
        end
        if temprepulse[1]^2+temprepulse[2]^2!=0.
            temprepulse/=Nr
            temprepulse.-=positions[i]
            orientations[i][1]-=temprepulse[1]/sqrt(temprepulse[1]^2+temprepulse[2]^2)*paramRepWeight
            orientations[i][2]-=temprepulse[2]/sqrt(temprepulse[1]^2+temprepulse[2]^2)*paramRepWeight
            orientations[i]/=sqrt(orientations[i][1]^2+orientations[i][2]^2)
        end
    end
end

function updateBoidState(state::BoidState,size::Float64,vel::Float64,paramMaxRad::Float64,paramMinRad::Float64,paramPosWeight::Float64,paramRepWeight::Float64,paramVelWeight::Float64)
    newstate=deepcopy(state)
    ruleOrientations!(newstate.orientations,newstate.positions,paramMaxRad,paramVelWeight)
    rulePosition!(newstate.orientations,newstate.positions,paramMaxRad,paramMinRad,paramPosWeight,paramRepWeight)

    for i in eachindex(newstate.positions)
        newstate.positions[i].+=newstate.orientations[i]*vel
        if newstate.positions[i][1]>size
            newstate.positions[i][1]=2*size-newstate.positions[i][1]
            newstate.orientations[i][1]*=-1
        end
        if newstate.positions[i][1]<0
            newstate.positions[i][1]*=-1
            newstate.orientations[i][1]*=-1
        end
        if newstate.positions[i][2]>size
            newstate.positions[i][2]=2*size-newstate.positions[i][2]
            newstate.orientations[i][2]*=-1
        end
        if newstate.positions[i][2]<0
            newstate.positions[i][2]*=-1
            newstate.orientations[i][2]*=-1
        end
    end

    return newstate
end

function randomOrientation()
    th=rand(Float64)*2*π
    return [cos(th),sin(th)]
end

function initializeRandomBoidState(numboids::Int64,size::Float64)
    return BoidState([[rand(Float64)*size,rand(Float64)*size] for i in 1:numboids],[randomOrientation() for i in 1:numboids])
end

function run(numboids::Int64,steps::Int64,size::Float64,vel::Float64,paramMaxRad::Float64,paramMinRad::Float64,paramPosWeight::Float64,paramRepWeight::Float64,paramVelWeight::Float64)
    out=[initializeRandomBoidState(numboids,size)]
    for i in 1:steps
        push!(out,updateBoidState(out[i],size,vel,paramMaxRad,paramMinRad,paramPosWeight,paramRepWeight,paramVelWeight))
    end
    return out
end


end
