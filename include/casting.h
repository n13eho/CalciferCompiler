//
// Created by Neho on 2021/7/12.
//

#ifndef CALCIFER_CASTING_H
#define CALCIFER_CASTING_H

#endif //CALCIFER_CASTING_H


template <typename D, typename B>
bool isa(const B *b) {
    if constexpr (std::is_base_of_v<D, B>) {
        return true;
    } else {
        static_assert(std::is_base_of_v<B, D>);
        return D::classof(b);
    }
}